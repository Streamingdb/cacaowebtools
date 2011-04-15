(* Written by me. This document is distributed under the terms of the recursive license *)

open Printf

module HTTPServer = 
struct
  type httprequest = 
      {
        path: string; (* le chemin de la requete *)
        arguments: (string * string) list; (* les parametres passes dans l'url *)
        headers: string;
      }

  type transactionstate = Accepted | RequestReceived | ReplySent
  type transaction =
      {
        tcpsocket: Unix.file_descr;
        mutable filedescr: Unix.file_descr option;
        ipaddress: string; (* l'ip est recuperee a l'accept, avant qu'il n'arrive quelque chose au socket *)
        mutable transactionstate: transactionstate;
        writequeue: string Queue.t;
        currentpartialread: Buffer.t;
        currentpartialsent: Buffer.t;
        timecreated: float;
      }

  type show = 
      { 
        showname : string; 
        seasonid : string; 
        episodeid : string; 
        showlink : string; 
      }
  type movie =
      {
        moviename : string;
        movielink : string;
      }
  let dbconn = MySQL.openconnection "127.0.0.1" "root" "" "cacaowebsearch"
  
  let httpserversock = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0
  let httpserverport = 80
  let httpserveraddr = Unix.ADDR_INET(Unix.inet_addr_any, httpserverport)
  let maxconnecting = 100
  let transactionTimeout = 15.0
  let defaultbuffersize = 16384
  let timerDoTasks = ref 0.0
                     
  let httpheader = format_of_string "HTTP/1.1 200 OK\r\n\
Content-Length: %i\r\n\
Connection: Close\r\n\
Content-Type: application/javascript; charset=utf-8\r\n\r\n"
                                                 
  let tvshowslist = ref []
  let movieslist = ref []
  let readbuf = String.create defaultbuffersize
  let transactions = ref []

 
  let init_matrix n m =
    let init_col = Array.init m in
    Array.init n (function
                    | 0 -> init_col (function j -> j)
                    | i -> init_col (function 0 -> i | _ -> 0))

  let levenshteindistance (x : int array) y =
    match (Array.length x, Array.length y) with
      | (0, n) -> n
      | (m, 0) -> m
      | (m, n) ->
        let matrix = init_matrix (m + 1) (n + 1) in
        for i = 1 to m do
          let s = matrix.(i) and t = matrix.(i - 1) in
          for j = 1 to n do
            let cost = abs (compare x.(i - 1) y.(j - 1)) in
            s.(j) <- min (t.(j) + 1) (min (s.(j - 1) + 1) (t.(j - 1) + cost))
          done
        done;
        matrix.(m).(n)

  let convertstringtointarray s = 
    Array.init (String.length s) (fun i -> int_of_char s.[i])

  let distance s1 s2 = levenshteindistance (convertstringtointarray s1) (convertstringtointarray s2)

  let querydistance s1 s2 = 0 (* TODO: si s1 est contenue dans s2 ou s2 contenue dans s1, alors 1 sinon levenshtein *)

  
  let query_string http_frame =
    if String.contains http_frame ' ' then
      let i0 = String.index http_frame ' ' in (* on prend l'espace qui doit etre apres le GET dans la frame http *)
      let q0 = Utils.prefix http_frame i0 in
      (match q0 with
           ("GET" | "HEAD" | "POST") -> (*assert (printf "%s\n" http_frame; true);*)
           let i1 = succ i0 in
           let i2 = String.index_from http_frame i1 ' ' in (* c'est faux, on veut pouvoir accepter les espaces dans l'url *)
           let headers = if String.contains_from http_frame (i2+1) '\n' then Utils.suffix http_frame ((String.index_from http_frame (i2+1) '\n') + 1) else "" in
           let q = String.sub http_frame i1 (i2-i1) in (* la requete *)
           let path = if String.contains q '?' then Utils.prefix q (String.index q '?') else q in
           if String.contains q '?' then
             let i = String.index q '?' in
             let args = Utils.suffix q (succ i) in
             let arguments = List.map (fun s -> let myargs = Utils.split s '=' in if List.length myargs >= 2 then (List.nth myargs 0, List.nth myargs 1) 
                                                 else ("", "")) (Utils.split args '&') in
             Some { path = path; arguments = arguments; headers = headers; }
           else
             Some { path = path; arguments = []; headers = headers; }
          | _ -> printf "Unsupported method: %s\n" q0; None)
    else
      (printf "bad http frame\n";
       None)

  let closetransaction trans = (*assert (printf "closing transaction\n"; true);*)
    (try Unix.close trans.tcpsocket with Unix.Unix_error (Unix.ECONNRESET, "close", "") (* peut se produire sous BSD uniquement *) -> () | ex -> raise ex);
    transactions := List.filter ((!=) trans) !transactions
  
  let processAnswer trans = 
    match trans.transactionstate with 
        Accepted -> 
        let c = Buffer.contents trans.currentpartialread in
        if Utils.indexof "\r\n\r\n" c > -1 then 
          (let res = query_string c in
           (match res with
                Some r ->
                let entryterm = if List.mem_assoc "searchterm" r.arguments then String.lowercase (Utils.decode (List.assoc "searchterm" r.arguments)) else "" in 
                let lang = if List.mem_assoc "lang" r.arguments then List.assoc "lang" r.arguments else "" in 
                let resultlistposition = if List.mem_assoc "pos" r.arguments then int_of_string (List.assoc "pos" r.arguments) else 0 in 
                printf "entry search term = %s; lang = %s; resultlistposition = %i\n" entryterm lang resultlistposition;
                let showsresultslist = ref [] in 
                let moviesresultslist = ref [] in 
                let didyoumeanresultslist = ref [] in 
                let finddidyoumeaninlist searchterm lang searchlist = (* on ne prend le did you mean que dans la langue de l'utilisateur *)
                  let langsearchlist = if List.mem_assoc lang searchlist then List.assoc lang searchlist else [] in 
                  List.filter (fun a -> distance a searchterm < (String.length searchterm) / 2) langsearchlist in 
                let findmatchinginlist searchterm lang searchlist = (* find a matching element if possible, otherwise returns None *)
                  (* TODO: lorsque lang n'est pas propose, on fait le tour de tous les langages *)
                  let langsearchlist = if List.mem_assoc lang searchlist then List.assoc lang searchlist else [] in 
                  if List.mem searchterm langsearchlist then 
                    Some searchterm
                  else if List.exists (fun a -> Utils.indexof searchterm a = 0) langsearchlist then 
                    (let sequence = List.hd (List.filter (fun a -> Utils.indexof searchterm a = 0) langsearchlist) in 
                     printf "start subsequence of : %s\n" sequence;
                     Some sequence)
                  else
                    (let sequence = List.fold_left (fun b a -> if Utils.indexof searchterm a > -1 then a else b) "" langsearchlist in 
                     if sequence <> "" then 
                       (printf "subsequence of : %s\n" sequence;
                        Some sequence)
                     else
                       (let (closerresult, d) = List.fold_left (fun (s, d) a -> if distance a searchterm < d then (a, distance a searchterm) else (s, d)) ("", 100) langsearchlist in 
                        if d < 3 then 
                          (printf "closer = %s ; distance = %i\n" closerresult d;
                           Some closerresult)
                        else
                          None)) in 
                let processmatchingshows resultmatch langopt = (* gets all the episode for some matching show *)
                  
                  let sql = sprintf "SELECT title,seasonid,episodeid,fileid FROM tvshows \
WHERE title LIKE '%s' %s \
ORDER BY seasonid DESC,episodeid DESC \
LIMIT %i,10" (MySQL.mysqlescape dbconn resultmatch) (match langopt with Some lang -> sprintf "AND lang LIKE '%s'" lang | None -> "") resultlistposition in 
                  let res = MySQL.do_sql_select dbconn sql in 
                  showsresultslist := List.map (fun a -> let link = "http://127.0.0.1:4001/" ^ 
                                                 (if String.length a.(3) <= 10 then "megavideo/megavideo.caml?videoid=" ^ a.(3) else "?f=" ^ (String.lowercase a.(3))) in 
                                               { showname = a.(0); seasonid = a.(1); episodeid = a.(2); showlink = link; }) (Array.to_list res) in 
                let processmatchingmovies resultmatch langopt = 
                  let sql = sprintf "SELECT title,fileid FROM movies \
WHERE title LIKE '%s' %s \
LIMIT %i,10" (MySQL.mysqlescape dbconn resultmatch) (match langopt with Some lang -> sprintf "AND lang LIKE '%s'" lang | None -> "") resultlistposition in 
                  let res = MySQL.do_sql_select dbconn sql in 
                  moviesresultslist := List.map (fun a -> let link = "http://127.0.0.1:4001/" ^ 
                                                 (if String.length a.(1) <= 10 then "megavideo/megavideo.caml?videoid=" ^ a.(1) else "?f=" ^ (String.lowercase a.(1))) in 
                                               { moviename = a.(0); movielink = link; }) (Array.to_list res) in 
                (match findmatchinginlist entryterm (Some lang) !tvshowslist with (* on commence par les shows *)
                     Some resultmatch -> processmatchingshows resultmatch (Some lang)
                   | None -> (match findmatchinginlist entryterm None !tvshowslist with 
                                  Some resultmatch -> processmatchingshows resultmatch None
                                | None -> (match findmatchinginlist entryterm (Some lang) !movieslist with (* on poursuit par les movies *)
                                               Some resultmatch -> processmatchingmovies resultmatch (Some lang)
                                             | None -> (match findmatchinginlist entryterm None !movieslist with 
                                                            Some resultmatch -> processmatchingmovies resultmatch None
                                                          | None -> 
                                                            (didyoumeanresultslist := finddidyoumeaninlist entryterm lang !tvshowslist;
                                                             didyoumeanresultslist := (finddidyoumeaninlist entryterm lang !movieslist) @ !didyoumeanresultslist))))); 
                let showsdata = List.fold_left (fun b show -> b ^ "\t\t{\"showname\": \"" ^ show.showname ^ "\",\n\t\t\"season\": " ^ show.seasonid ^ ",\n\t\t\"episode\": " ^ 
                                                                 show.episodeid ^ ",\n\t\t\"link\": \"" ^ show.showlink ^ "\" },\n") "" !showsresultslist in 
                let formattedshowsdata = if showsdata = "" then "" else String.sub showsdata 0 (String.length showsdata - 2) in 
                let moviesdata = List.fold_left (fun b movie -> b ^ "\t\t{\"moviename\": \"" ^ movie.moviename ^ "\",\n\t\t\"link\": \"" ^ movie.movielink ^ "\" },\n") "" !moviesresultslist in 
                let formattedmoviesdata = if moviesdata = "" then "" else String.sub moviesdata 0 (String.length moviesdata - 2) in 
                let didyoumeandata = List.fold_left (fun b result -> b ^ "\t\t\"" ^ result ^ "\",\n") "" !didyoumeanresultslist in 
                let formatteddidyoumeandata = if didyoumeandata = "" then "" else String.sub didyoumeandata 0 (String.length didyoumeandata - 2) in 
                let data = 
                  "var results = {\n\t\"language\": \"" ^ lang ^ "\", \n\t\"showsresults\": \n\t\t[ \n" ^ formattedshowsdata ^ "\n\t\t], \n\t\"moviesresults\": \n\t\t[ \n" ^ formattedmoviesdata ^ 
                  "\n\t\t], \
\n\t\"didyoumeanresults\": \n\t\t[ \n" ^ formatteddidyoumeandata ^ "\n\t\t]\n};\n\
parsesearchresults(results);" in 
                let result = (sprintf httpheader (String.length data)) ^ data in 
                Queue.push result trans.writequeue;
                trans.transactionstate <- ReplySent
              | None -> 
                printf "http request not usable\n"))
      | (RequestReceived | ReplySent) -> 
        assert (printf "wrong state in processAnswer\n"; true)
        
  let accept_handler rsock = (*assert(printf "%f, accepting connection on listening socket\n" (Unix.gettimeofday ()); true);*)
    let res = try 
      Some (Unix.accept rsock) 
    with
        Unix.Unix_error (err, "accept", b) -> assert (eprintf "%f, erreur %s dans accept %s\n" (Unix.gettimeofday ()) (Unix.error_message err) b; true); None
      | ex -> raise ex in
    match res with
        Some (sock, addr ) -> 
        transactions := { tcpsocket = sock; ipaddress = (match addr with Unix.ADDR_INET(x, _) -> Unix.string_of_inet_addr x | _ -> ""); transactionstate = Accepted; filedescr = None; 
                            writequeue = Queue.create (); currentpartialread = Buffer.create 16; currentpartialsent = Buffer.create 16; timecreated = Unix.gettimeofday (); } :: !transactions;
        Unix.set_nonblock sock
      | None -> assert (eprintf "%f, error during accept\n" (Unix.gettimeofday ()); true)
  
  let read_handler sock = 
    let trs = List.filter (fun trans -> trans.tcpsocket = sock) !transactions in 
    if List.length trs > 0 then (* le socket a peut etre ete tue dans write_handler juste avant *)
      let trans = List.hd trs in
      let len = 
        try
          Unix.recv trans.tcpsocket readbuf 0 16384 []
        with 
             Unix.Unix_error (err, "recv", _)  -> assert (printf "%f, erreur %s in readhandler\n" (Unix.gettimeofday ()) (Unix.error_message err); true); 0
          | ex -> raise ex in
        if len = 0 then
          ((*assert (printf "0 characters read, closing tcp connection in read_handler\n"; true);*)
           closetransaction trans)
        else
          (Buffer.add_string trans.currentpartialread (String.sub readbuf 0 len);
           processAnswer trans)
    else
      assert (eprintf "%f, the socket didnt exist anymore in read_handler\n" (Unix.gettimeofday ()); true)

  let write_handler sock = 
    let trans = List.hd (List.filter (fun trans -> trans.tcpsocket = sock) !transactions) in 
    let data = if Buffer.length trans.currentpartialsent > 0 then Buffer.contents trans.currentpartialsent else Queue.pop trans.writequeue in 
    let len = 
      try
        Unix.send sock data 0 (String.length data) []
      with
           Unix.Unix_error (err, "send", "") -> 
           assert (printf "%f, erreur %s dans write_handler\n" (Unix.gettimeofday ()) (Unix.error_message err); true);
           closetransaction trans; 
           0
         | ex -> raise ex in 
    Buffer.clear trans.currentpartialsent;
    if len < String.length data then 
      (if len = -1 then 
         failwith "BIG WARNING NEVER SEEN: a Unix.send went wrong\n"
       else if len = 0 then
         ()
       else 
         ((*assert (printf "%f, a partial TCP packet was sent: %i out of %i\n" (Unix.gettimeofday ()) len (String.length data); true); *)
          Buffer.add_string trans.currentpartialsent (String.sub data len ((String.length data) - len))))
  
  let getAllSockets () =
    (httpserversock :: (List.map (fun trans -> trans.tcpsocket) !transactions), 
     List.map (fun trans -> trans.tcpsocket) (List.filter (fun trans -> not (Queue.is_empty trans.writequeue) || Buffer.length trans.currentpartialsent > 0) !transactions))

  let rdispatcher rsock =
    if rsock = httpserversock then 
      accept_handler rsock 
    else 
      read_handler rsock
  
  let init () =
    Random.self_init ();
    Unix.setsockopt httpserversock Unix.SO_REUSEADDR true;
    Unix.bind httpserversock httpserveraddr;
    Unix.listen httpserversock maxconnecting;
    Unix.set_nonblock httpserversock;
    let sqlutf8 = "SET NAMES utf8" in 
    MySQL.do_sql_noselect dbconn sqlutf8;
    let sql = sprintf "SELECT lang,LOWER(title) FROM tvshowslist ORDER BY lang" in 
    let res = MySQL.do_sql_select dbconn sql in 
    Array.iter (fun a -> if not (List.mem_assoc a.(0) !tvshowslist) then 
                tvshowslist := (a.(0), [a.(1)]) :: !tvshowslist 
              else
                (let l = List.assoc a.(0) !tvshowslist in 
                 tvshowslist := (a.(0), a.(1) :: l) :: (List.remove_assoc a.(0) !tvshowslist))) res;
    let sqlmovies = sprintf "SELECT lang,LOWER(title) FROM movieslist ORDER BY lang" in 
    let res = MySQL.do_sql_select dbconn sqlmovies in 
    Array.iter (fun a -> if not (List.mem_assoc a.(0) !movieslist) then 
                movieslist := (a.(0), [a.(1)]) :: !movieslist
              else
                (let l = List.assoc a.(0) !movieslist in 
                 movieslist := (a.(0), a.(1) :: l) :: (List.remove_assoc a.(0) !movieslist))) res
    
    

  let mainLoop () =
    let t = ref 0.0 in
    while true do
      assert(flush stdout; flush stderr; true);
      t := Unix.gettimeofday ();
      if !t -. !timerDoTasks > 1.0 then 
        (timerDoTasks := !t; 
         List.iter (fun trans -> if Unix.gettimeofday () -. trans.timecreated > transactionTimeout then closetransaction trans) !transactions);
      let ss = getAllSockets () in
      let rsocks, wsocks, _ = Unix.select (fst ss) (snd ss) [] 0.2 in
      List.iter write_handler wsocks;
      List.iter rdispatcher rsocks
    done                               

      
end;;

HTTPServer.init ();;
HTTPServer.mainLoop ();;

