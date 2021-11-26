%{
#include "bison.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
void yyerror(const char *);
char canacceptnewline = 0;


%}	

%option noyywrap
%option yylineno
%x STRNG

%%

[ \t]                           ;

"INTEGER"				        {return INTEGER;}
"CHAR"					        {return CHAR;}
"PROGRAM"				        {canacceptnewline = 1; return PROGRAM;}
"FUNCTION"				        {canacceptnewline = 1; return FUNCTION;}
"VARS"					        {return VARS;}
"END_FUNCTION"			        {return END_FUNCTION;}
"RETURN"				        {return RETURN;}
"STARTMAIN"				        {return STARTMAIN;}
"ENDMAIN"				        {return ENDMAIN;}
"WHILE" 				        {return WHILE;}
"ENDWHILE" 				        {return ENDWHILE;}
"FOR"					        {return FOR;}
"TO" 					        {return TO;}
"STEP" 					        {return STEP;}
"ENDFOR" 				        {return ENDFOR;}
"IF"					        {return IF;}
"THEN"  				        {return THEN;}
"ELSEIF" 				        {return ELSEIF;}
"ELSE"					        {return ELSE;}
"ENDIF" 				        {return ENDIF;}
"SWITCH" 				        {return SWITCH;}
"CASE" 					        {return CASE;}
"DEFAULT" 				        {return DEFAULT;}
"ENDSWITCH" 			        {return ENDSWITCH;}
"PRINT"					        {return PRINT;}
"BREAK" 				        {return BREAK;}
"("						        {return APAR;}
")"						        {return KPAR;}
"["                             {return AAGKYLI;}
"]"                             {return DAGKYLI;}
":"						        {return AKTELIA;}
","						        {return KOMMA;}
"="						        {return ISON;}
";"						        {return ERWT;}
":="                            {return ISONF;}

\%.*\n    			            {return COMMENT;}
"OR"|"AND"  		            {return L_OP;}

[a-zA-Z_]+[a-zA-Z0-9_]*	        {return ID;}

\'[a-zA-Z0-9]\'                 {return CHRCTER;}
([1-9]+[0-9]*|0)                {return INT;}

\"                              { BEGIN(STRNG); }
<STRNG>\"                       { BEGIN(INITIAL); return STRING; }
<STRNG>(\\.|[^"\\])
<STRNG><<EOF>>                  { printf("detected string in incorrect format\n"); }

\+|\- 	                        {return NUM_OP;}
\*|\/                           {return MUL_DIV_OP;}
\^                              {return POWER_OP;}

">"|"<"|">="|"<="               {return COMP_OP;}
"!="|"=="                       {return EQ_NOEQ_OP;}

"\n"					        { 
                                    if (canacceptnewline == 1){
                                        canacceptnewline = 0;
                                        return NEWLINE;
                                    }
                                }

<<EOF>> 				        {return 0;}
.       				        {yyerror(yytext);}

%%

void yyerror(const char * msg) {
    printf("Error in line %d. Error type is %s\n", yylineno, msg);
}

