%{
#include "y.tab.h"
#include <stdlib.h>

void yyerror(char *);

%}


%%
[\/+\-\*\^]  	{return *yytext;}
[\(\)]		{return *yytext;}
\n		{return FIM;}
[0-9]+ 		{yylval = atoi(yytext);
		 return INT;}
[[:space:]]+ ;					/*Todos os espaços são ignorados pela calculadora*/
. 		{yyerror("E");}			/*Caso nenhuma regra seja acionada, um erro será gerado*/
%%

int yywrap(){
	return 1;
}
