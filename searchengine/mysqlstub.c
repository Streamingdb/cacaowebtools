
#include "mlvalues.h"
#include "memory.h"
#include "fail.h"
#include "alloc.h"
#include "callback.h"
#include "custom.h"
#include "signals.h"

#include <stdio.h>
//#include "my_global.h"
#include "mysql.h"




static struct custom_operations ops;

value caml_open(value host, value user, value password, value dbname)
{
      MYSQL *mysql;
      CAMLparam4(host, user, password, dbname);
      CAMLlocal1(res);
      
      mysql = mysql_init(NULL);

      if (!mysql_real_connect(mysql, String_val(host), String_val(user), String_val(password), String_val(dbname), 0, NULL, 0)){
         printf("%s\n", mysql_error(mysql));
      }
      res = caml_alloc_custom(&ops, sizeof(MYSQL *), 0, 1);
      //(*((MYSQL **) Data_custom_val(res))) = mysql;
      Store_field(res, 0, (value) mysql);
      
      CAMLreturn(res);
}
void caml_close(value dbconn)
{
      MYSQL *mysql;
      CAMLparam1(dbconn);
      mysql = (MYSQL *) Field(dbconn, 0);
      mysql_close(mysql);
      mysql_library_end();
      printf("closed\n");
      CAMLreturn0;
} 
void caml_do_noselect(value dbconn, value sql)
{
      MYSQL *mysql;
      CAMLparam2(dbconn, sql);
      
      //char * sql = String_val(camlsql);
      //char esc_sql[1000];
      //unsigned int len;
      
      //mysql = (MYSQL*) Data_custom_val(dbconn);
      mysql = (MYSQL *) Field(dbconn, 0);
      //len = mysql_real_escape_string(mysql, esc_sql, sql, string_length(camlsql));
         
      if (mysql_real_query(mysql, String_val(sql), string_length(sql))){
         printf("Mysql.exec: %s", mysql_error(mysql));
      }
      
      CAMLreturn0 ;
}
value caml_do_select(value dbconn, value sql)
{
      MYSQL *mysql;
      CAMLparam2(dbconn, sql);
      CAMLlocal2(cres, crow);
      
      mysql = (MYSQL *) Field(dbconn, 0);
         
      if (mysql_real_query(mysql, String_val(sql), string_length(sql))){
         printf("Mysql.exec: %s", mysql_error(mysql));
      }else{
            MYSQL_RES *res;
            MYSQL_ROW row;
            unsigned int num_fields;
            unsigned int i, j;
            unsigned int num_rows;
            res = mysql_store_result(mysql);
            num_fields = mysql_num_fields(res);
            //printf ("num fields = %i\n",num_fields);
            num_rows = mysql_num_rows(res);
            //printf ("num_rows = %i\n",num_rows);
            cres = caml_alloc(num_rows, 0);
            for(j = 0; j< num_rows; j++){
                  unsigned long *lengths;
                  
                  row = mysql_fetch_row(res);
                  crow = caml_alloc(num_fields, 0);
                  lengths = mysql_fetch_lengths(res);
                  for(i = 0; i < num_fields; i++){
                        //printf("[%.*s] ", (int) lengths[i], row[i] ? row[i] : "NULL");
                        Store_field(crow, i, caml_copy_string(row[i]));
                  }
                  Store_field(cres, j, crow);
                  //printf("\n");
            }
            mysql_free_result(res);
      }     
       
      CAMLreturn(cres);
}
value caml_escape_string(value dbconn, value s)
{
      MYSQL *mysql;
      CAMLparam2(dbconn, s);
      CAMLlocal1(res);
	  
	  char escapedstring[16384];
      
	  mysql = (MYSQL *) Field(dbconn, 0);
	  
      mysql_real_escape_string(mysql, escapedstring, String_val(s), string_length(s));
	  
	  res = caml_copy_string(escapedstring);
     
      CAMLreturn(res);
}



