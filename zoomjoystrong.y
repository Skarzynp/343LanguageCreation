/**********************************************************************
*Parser that takes tokens and creates graphics from them
*@author Parker Skarzynski
*@version 4/11/2018
*
**********************************************************************/


%{
	#include <stdio.h>
	#include <string.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();

%}


%error-verbose
%start statement_list

%union { int i; float j;char*str; }

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT


%type <str> END
%type<str> END_STATEMENT
%type<str> POINT
%type <str> LINE
%type <str> CIRCLE
%type<str>  RECTANGLE
%type<str> SET_COLOR
%type<i> INT
%type<j> FLOAT





%%

statement_list:	statement 
	|	statement  statement_list
;

statement:	line_statement
		|	point_statement
		|	circle_statement
		|	rectangle_statement
		|	color_statment
;
line_statement:	LINE  INT INT INT INT END_STATEMENT
	{
		
		if($2 >= 0 && $3 >= 0 && $4 >= 0 && $5 >= 0){
			   if($2 <= WIDTH  && $3 <= HEIGHT && $4 <= WIDTH && $5 <= HEIGHT){
				line($2,$3,$4,$5);

			}

		}





	}
;
point_statement: POINT  INT INT END_STATEMENT
	{
		if($2 > 0 && $3 > 0){
		 	if($2 <= WIDTH  && $3 <=  HEIGHT){
					point($2,$3);

		}

		}

	}
;

circle_statement: CIRCLE INT INT INT END_STATEMENT
	{
		if($2 >= 0 && $3 >=0){
		if($2 <= WIDTH && $3 <= HEIGHT){
			circle($2,$3,$4);
	}
	}
	}
;
rectangle_statement: RECTANGLE  INT INT INT INT END_STATEMENT
	{
		if($2 >= 0 && $3 >= 0 && $4 >= 0 && $5 >= 0){
		if($2 <= WIDTH  && $3 <= HEIGHT && $4 <= WIDTH && $5 <= HEIGHT){

		        rectangle($2,$3,$4,$5);

		}

		}
	}
;
color_statment: SET_COLOR  INT INT INT END_STATEMENT
	{
		 if($2 >= 0 && $3 >= 0 && $4 >= 0){
			if($2<=255 && $3<=255 && $4<=255){
                          set_color($2,$3,$4);
		}
		}
	}
;

%%
/**********************************************************************
*Main that setups parser and parses it and then exits the program
*Meant to be a drawing program
*
**********************************************************************/
int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;
}
/**********************************************************************
*Prints out parser error method
*was given to us in class

**********************************************************************/
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
