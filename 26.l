%{
#include <stdio.h>
#include <ctype.h>

void print_token(const char *token_type, const char *value) {
    printf("%s: %s\n", token_type, value);
}
%}

%%

[ \t\n]+               ;

"/*"([^*]|\*+[^/])*\*+"/"  ;

"//".*\n               ; 

[0-9]+                  { print_token("Constant", yytext); }

[A-Za-z][A-Za-z0-9]*    { print_token("Identifier", yytext); }

"+"|"-"|"*"|"/"|"="    { print_token("Operator", yytext); }

.                      { printf("Unknown character: %s\n", yytext); }

%%
int yywrap( ){}
int main(int argc, char **argv) {
    yylex();
    return 0;
}
