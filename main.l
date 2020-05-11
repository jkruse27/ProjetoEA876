%{
#include "y.tab.h"
#include <stdlib.h>

void yyerror(char *);

%}


%%
[\+\-\*\^]  	{ yylval = *yytext;
		  return OP;}
[()]		{return *yytext;}
[\n]		{return FIM;}
[0-9]+ 		{yylval = atoi(yytext);
		 return INT;}
[[:space:]]+ ;
. 		{yyerror("E");}
%%

int yywrap(){
	return 1;
}
