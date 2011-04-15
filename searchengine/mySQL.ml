open Printf

type dbconn

external openconnection : string -> string -> string -> string -> dbconn = "caml_open"
external do_sql_select : dbconn -> string -> string array array = "caml_do_select"
external do_sql_noselect : dbconn -> string -> unit = "caml_do_noselect"
external closeconnection : dbconn -> unit = "caml_close"
external mysqlescape : dbconn -> string -> string = "caml_escape_string"
