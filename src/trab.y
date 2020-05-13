%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

void yyerror(char *);
int yylex(void);
int c = 0;		/*A variável global é usada para gerar nomes de rótulos diferentes*/
%}

%token INT FIM  
%left  '+' '-'		/*Os comandos left são usados para gerar a precedência entre as operações*/ 
%left '*' 
%left '^'

%%

ARQ:
   	EXPRESSAO FIM { printf("POP A\n"); }	/*O resultado da operação é armazenado no registrador A no final do programa em Assembly*/
	|
	;

EXPRESSAO:
	 INT {$$ = $1;}
	 | '(' EXPRESSAO ')' 		{$$ = -1;}	/*Para saber quando a expressão ja foi calculada e seu resultado está empilhado, o marcador -1 é passado*/
	| EXPRESSAO '^' EXPRESSAO {
		if($1==-1)				/*Caso o primeiro valor da conta esteja empilhado*/
			printf("POP A\n");
		else
			printf("MOV A, %d\n", $1);	/*Caso contrário, o valor é carregado diretamenta no registrador*/
		if($3==-1)				/*Caso o segundo valor da conta esteja empilhado*/
			printf("POP B\n");
		else
			printf("MOV B, %d\n", $3);	/*Caso contrário*/
		printf("CMP B, 0\nJZ final%d\nCMP B, 1\nJZ rot%d\nloop%d:\n\tMUL A\n\tSUB B, 1\n\tCMP B, 1\n\tJNZ loop%d\nrot%d:\n\tPUSH A\n\tJMP dps%d\nfinal%d:\n\tPUSH 1\ndps%d: \n",c,c,c,c,c,c,c,c);
		c++;					/*A expressão acima gera o código que implementa a exponenciação no código de Assembly*/
		$$ = -1;}			      
	| EXPRESSAO '*' EXPRESSAO {
		if($1==-1)
			printf("POP A\n");
		else
			printf("MOV A, %d\n", $1);
		if($3==-1)
			printf("POP B\n");
		else
			printf("MOV B, %d\n", $3);
		printf("MUL B\nPUSH A\n");
		$$ = -1;}			      
	| EXPRESSAO '+' EXPRESSAO {
		if($1==-1)
			printf("POP A\n");
		else
			printf("MOV A, %d\n", $1);
		if($3==-1)
			printf("POP B\n");
		else
			printf("MOV B, %d\n", $3);
		printf("ADD A, B\nPUSH A\n");
		$$ = -1;}			      
	| EXPRESSAO '-' EXPRESSAO {
		if($1==-1)
			printf("POP A\n");
		else
			printf("MOV A, %d\n", $1);
		if($3==-1)
			printf("POP B\n");
		else
			printf("MOV B, %d\n", $3);
		printf("SUB A, B\nPUSH A\n");
		$$ = -1;}			      
	;
%%

void yyerror(char *s) { printf("Expressão Inválida\n"); }

int main() {
  yyparse();
  return 0;

}
