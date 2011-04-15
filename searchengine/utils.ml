open Printf

let prefix s n = String.sub s 0 n (* n est la longueur de la sous-chaine *)

let suffix s i = String.sub s i (String.length s - i) (* i est la position a laquelle on commence *)

let rec split s c =
  if String.contains s c then 
    let i = String.index s c in
    let s1, s2 = prefix s i, suffix s (i+1) in
      s1::(split s2 c)
  else
    [s]

(** convert a string to its hex representation *)
let convertToHex s = 
  let rec convertListToHex = function (* take a list of chars and returns a string *)
      [] -> ""
    | t :: q -> (sprintf "%02X" (Char.code t)) ^ (convertListToHex q) in
  let rec tolist = function
      "" -> []
| s -> s.[0] :: tolist (String.sub s 1 (String.length s - 1)) in
convertListToHex (tolist s)

(** dit si la premiere chaine est contenue dans la seconde par algo naif *)
let indexofuntil s1 s2 n = (* attention, des fonctions unsafe sont utilisees TODO: remplacer get par unsafe_get *)
  let pos = ref (-1) in
  if s1 <> "" then 
    (let c1 = String.get s1 0 in 
     let i = ref 0 in 
       while !pos = -1 && !i <= n - String.length s1 do
        if c1 = String.get s2 !i then 
          (let j = ref 1 in 
             while !j < String.length s1 && String.get s1 !j = String.get s2 (!i + !j) do j := succ !j done;
             if !j = String.length s1 then pos := !i);
        i := succ !i
      done);
  !pos

let indexof s1 s2 = indexofuntil s1 s2 (String.length s2)
 
let indexoffrom s1 s2 p = 
  if p < String.length s2 then let pos = indexof s1 (suffix s2 p) in if pos > -1 then pos + p else -1 else -1

let decode s =
  let i = ref 0 in 
  let res = ref "" in 
  while !i < String.length s do
    res := !res ^ 
    (match s.[!i] with (* TODO: controles a ajouter *)
        '+' -> " "
      | '%' -> 
        i := !i + 2;
        sprintf "%c" (char_of_int (int_of_string (sprintf "0x%c%c" s.[!i-1] s.[!i])))
      | c -> sprintf "%c" c);
    i := !i + 1
  done;
  !res


