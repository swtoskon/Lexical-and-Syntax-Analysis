%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define T_CLASS 250
#define T_PROPERTY 251
#define T_URI 252

int i=0,j=0,y=0;

%}

newline \n|\x0A|\x0D\x0A
space " "
letter [A-Za-z]
ls \"
dd \/
pp \#
classStart <owl:Class{space}rdf:ID=
Name {letter}{letter}*
nzdigit [1-9]
digit (0|{nzdigit})
digits {digit}+
ip ({Name}|{digit}|\-|\/|\+|\.|\.owl|{pp})*
class {classStart}{ls}({Name}|\_|\-|\+)*{ls}(\/)?>
propertyStart <owl:ObjectProperty{space}rdf:ID=|<owl:FunctionalProperty{space}rdf:ID=|<owl:DatatypeProperty{space}rdf:ID=
property {propertyStart}{ls}{Name}{ls}(\/)?>
uriStart  {ls}http:{dd}{dd}(www\.)?
uri {uriStart}{ip}(\.)org(\/){ip}{ls}




%%

{newline} {/*do nothing */}
{class} {printf("Class: %s \n",yytext);i++;}
{property} {printf("Property: %s \n",yytext);j++; }
{uri} {printf("URI: %s \n",yytext);y++;}
.     {/* do nothing */}

%%

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
    
    printf("Number of Classes found: %d \n",i);
    printf("Number of Properties found: %d \n",j);
    printf("Number of URI's found: %d \n",y);
}

