%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

extern int yyval;
extern FILE *yyin;								
extern FILE *yyout;
extern void yyerror(const char *);
int yylex();
extern int yylineno;

%}

%define parse.error verbose

%token CHAR
%token INTEGER
%token INT
%token PROGRAM
%token FUNCTION
%token VARS
%token END_FUNCTION
%token RETURN
%token STARTMAIN
%token ENDMAIN
%token ID
%token STRING
%token WHILE
%token ENDWHILE
%token FOR
%token TO
%token STEP
%token ENDFOR
%token IF
%token THEN
%token ELSEIF
%token ELSE
%token ENDIF
%token SWITCH
%token CASE
%token DEFAULT
%token ENDSWITCH
%token PRINT
%token BREAK
%token AAGKYLI
%token DAGKYLI
%token NEWLINE 
%token CHRCTER
%token L_OP 
%token NUM_OP
%token MUL_DIV_OP
%token POWER_OP 
%token COMP_OP
%token EQ_NOEQ_OP;
%token APAR
%token KPAR
%token AKTELIA
%token KOMMA
%token ISON
%token ERWT
%token ISONF
%token COMMENT

%left KOMMA
%right ISON
%right ISONF
%left L_OP
%left EQ_NOEQ_OP
%left COMP_OP
%left NUM_OP 
%left MUL_DIV_OP 
%left POWER_OP
%left AAGKYLI DAGKYLI APAR KPAR

%%

sprogram: PROGRAM ID NEWLINE function_stm STARTMAIN main ENDMAIN;

orismata: pollapla_orismata | %empty;

pollapla_orismata: t_dedomenwn metblhtes | t_dedomenwn metblhtes KOMMA pollapla_orismata;

t_dedomenwn: CHAR | INTEGER;

tm_dhlwsewn: VARS dhlwseis | %empty;

dhlwseis: t_dedomenwn polles_metablites ERWT | t_dedomenwn polles_metablites ERWT dhlwseis;

polles_metablites: metblhtes | metblhtes KOMMA polles_metablites;

function_stm: FUNCTION ID APAR orismata KPAR NEWLINE tm_dhlwsewn multiple_stm RETURN expr ERWT END_FUNCTION function_stm | %empty; 

main: tm_dhlwsewn multiple_stm;

multiple_stm: stm multiple_stm | %empty;

stm: assignment | while_stm | for_stm | if_stm | switch_stm | print_stm | break_stm | n_function | COMMENT;

assignment: metblhtes ISON expr ERWT;

orismata_kaloumenis_sinartis_teliko: orismata_kaloumenis_sinartisis | %empty;

orismata_kaloumenis_sinartisis: expr | expr KOMMA orismata_kaloumenis_sinartisis;

n_function: ID APAR orismata_kaloumenis_sinartis_teliko KPAR;

while_stm: WHILE APAR cndtn KPAR multiple_stm ENDWHILE;

for_stm: FOR ID ISONF INT TO INT STEP INT multiple_stm ENDFOR;

else_stm: ELSE multiple_stm | %empty;

elseif_stm: ELSEIF APAR cndtn KPAR THEN multiple_stm elseif_stm | %empty; 

if_stm: IF APAR cndtn KPAR THEN multiple_stm elseif_stm else_stm ENDIF;

cndtn: cmprsn L_OP cndtn | cmprsn | APAR cndtn KPAR;

cmprsn: expr cmp_operator expr;

case_stm: CASE APAR expr KPAR AKTELIA multiple_stm case_stm | %empty;

default_stm: DEFAULT AKTELIA multiple_stm | %empty ;

switch_stm: SWITCH APAR expr KPAR case_stm default_stm ENDSWITCH;

expr: sistatika_expr mth_operator expr | sistatika_expr | APAR expr KPAR;

sistatika_expr: metblhtes | INT | CHRCTER | n_function | NUM_OP INT;

print_stm: PRINT APAR STRING KOMMA polles_metablites KPAR ERWT | PRINT APAR STRING KPAR ERWT;

break_stm: BREAK ERWT ;

metblhtes: ID | pinakas;

pinakas: ID AAGKYLI INT DAGKYLI;

mth_operator: NUM_OP | MUL_DIV_OP | POWER_OP;

cmp_operator: EQ_NOEQ_OP | COMP_OP
					    
%%								    

int main ( int argc, char **argv  ) {
	++argv; --argc;
	if ( argc > 0 )  yyin = fopen( argv[0], "r" );
	else    yyin = stdin;
	yyout = fopen( "output", "w" );	
	yyparse();

	printf("End of parsing\n");
	
	return 0;
}  