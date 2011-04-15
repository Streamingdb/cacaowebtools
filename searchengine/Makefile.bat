rem cl /I "C:\Program Files\Objective Caml\lib\caml" /I "C:\Program Files\Microsoft SDKs\Windows\v6.0a\Include" /I "C:\Program Files\Microsoft Visual Studio 9.0\VC\include"  /I "C:\Documents and Settings\ivan\My Documents\development\mysql-5.1.32\include" -c mysqlstub.c

rem ocamlc -g -verbose -custom libmysql.lib mysqlstub.obj -o extractfromlog.exe mySQL.ml extractfromlog.ml

ocamlc -g -verbose -custom libmysql.lib mysqlstub.obj -o search.exe unix.cma utils.ml mySQL.ml httpserver.ml