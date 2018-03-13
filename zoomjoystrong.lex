/**********************************************************************
*Lexer that defines tokens and passes them to the parser
*interputs tokens to create drawings
*@author Parker Skarzynski 
*
**********************************************************************/

%{

   #include <stdlib.h>
   #include <stdio.h>
   #include "zoomjoystrong.tab.h"

%}

%option noyywrap

%%


Q  		{yylval.str = strdup(yytext); return END;}
;		{yylval.str = strdup(yytext); return END_STATEMENT;}
P		{yylval.str = strdup(yytext); return POINT;}
L		{yylval.str = strdup(yytext); return LINE;}
circle	        {yylval.str = strdup(yytext); return CIRCLE;}
rectangle	{yylval.str = strdup(yytext); return RECTANGLE;}
color		{yylval.str = strdup(yytext); return SET_COLOR;}
[0-9]+		{yylval.i = atoi(yytext);     return INT;}
[0-9]+\.[0-9]+ 	{yylval.i = atof(yytext);    return FLOAT;}	
[\n\t ]		;
.		{printf("Invalid Entry");}



%%




