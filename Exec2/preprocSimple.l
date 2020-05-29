/*Simple Preprocessor */
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int i;


%}


newline \n|\x0A|\x0D\x0A
nzdigit [1-9]
digit (0|{nzdigit})
letter [A-Za-z]
id     {letter}({letter}|{digit}|_)*




%%

"x" {printf("%d",30);}
"y" {printf("CODEGEN");}
{id} {printf("%s",yytext);}
"INC("{id}")" {for(i=4;i<yyleng-1; i++){printf("%c",yytext[i]);}printf("++");}
"DEC("{id}")" {for(i=4;i<yyleng-1; i++){printf("%c",yytext[i]);}printf("--");}
"NEG("{id}")" {printf("-");for(i=4;i<yyleng-1; i++){printf("%c",yytext[i]);}}
{newline} {printf("%s",yytext);}
. {printf("%s",yytext);}


%%

/* The following code allows FLEX to access files from command line.. */ 
main( argc, argv )
int argc;
char **argv;
{

    
	   ++argv, --argc; /* skip over program name */
       if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
        else
         yyin = stdin;
    
        
	yylex(); 
	
}

