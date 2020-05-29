%{
#include <stdio.h>
#include <stdlib.h>
extern int line;
%}

%error-verbose

%token T_VAR
%token'('
%token ')'
%token'.'
%token ','
%token ';'
%token ':'
%token '&'
%token '!'
%token '?'



%token T_newline
%token T_NUM
%token T_NOT "not"
%token T_TRUE "true"
%token T_IMPLIES "<-"
%token T_ATOM 
%{
void yyerror (const char * msg);
%}

%left '+' '-'

%%






agent :beliefs plans
;

beliefs : beliefs belief
| /*empty*/
;

belief : predicate "."
;
predicate : T_ATOM "(" terms ")"
;
plans : plans plan
| /*empty*/
;
plan : triggering_event ":" context "<-" body ".";
triggering_event : "+" predicate
| "-" predicate
| "+" goal
| "-" goal
;
context : "true"
| cliterals
;
cliterals : literal
| literal "&" cliterals
;
literal : predicate | "not" "(" predicate ")";
goal :  "!" predicate | "?" predicate;
body : "true" | actions;
actions : action | action ";" actions;
action :predicate | goal | belief_update;
belief_update: "+" predicate | "-" predicate;
terms : term | term "," terms;
term : T_VAR | T_ATOM | T_NUM | T_ATOM "(" terms ")";


%%

void yyerror (const char * msg)
{
   printf("Error(line %d): %s\n",line, msg);
 
}


main(int argc, char **argv ){
  
  FILE *yyin;
   ++argv, --argc;  /* skip over program name */
   if ( argc > 0 )
       yyin = fopen( argv[0], "r" );
   else
      yyin = stdin;

   int result = yyparse();

   if (result == 0)
      printf("Syntax OK!\n");
   else
      printf("There were %d errors in code.Failure!\n",yynerrs);
   return result;
}








