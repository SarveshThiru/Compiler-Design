/* LEX code to count the frequency
of the given word in a file */

/* Definition section */
/* variable word indicates the word
whose frequency is to be count */
/* variable count is used to store the 
frequency of the given word */

%{
#include<stdio.h>
#include<string.h>

char word [] = "geeks";
int count = 0;
%}

%%
[a-zA-Z]+ { if(strcmp(yytext, word)==0)
				count++; }
. ;		 
%%
int yywrap()
{
	return 1;
}
int main()
{
		extern FILE *yyin, *yyout;
		
		/* open the input file
		in read mode */
		yyin=fopen("input.txt", "r");
		yylex();
		
		printf("%d", count);
	
}
