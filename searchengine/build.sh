#!bin/sh
#cc -c -I/usr/include/mysql -I/usr/lib/ocaml/3.10.2/caml mysqlstub.c
cc -shared -I/usr/include/mysql -I/usr/lib/ocaml/3.10.2/caml mysqlstub.c -L/usr/lib/mysql -lmysqlclient -o mysqlstub.so

ocamlc -g -verbose mysqlstub.so -o searchengine unix.cma utils.ml mySQL.ml httpserver.ml
#ocamlc -g -verbose -ccopt -L/usr/local/lib/mysql -cclib -lmysqlclient -custom mysqlstub.o -o adserver unix.cma utils.ml mySQL.ml httpserver.ml
#ocamlopt -g -verbose -ccopt -L/usr/local/lib/mysql -cclib -lmysqlclient mysqlstub.o -o adserver unix.cmxa utils.ml mySQL.ml httpserver.ml

