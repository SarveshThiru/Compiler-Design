%{
#include <stdio.h>
#include <string.h>

int i; // Declare the variable i here
%}

%%

[a-zA-Z]+ {
    int length = yyleng;
    for (i = 0; i < length - 2; i++) {
        if (yytext[i] == 'a' && yytext[i + 1] == 'b' && yytext[i + 2] == 'c') {
            yytext[i] = 'A';
            yytext[i + 1] = 'B';
            yytext[i + 2] = 'C';
            i += 2; // Skip next two characters as they are part of "abc"
        }
    }
    printf("%s", yytext);
}
[\t]+ { /* Skip tabs */ }
. { ECHO; }
\n { printf("\n"); }

%%

int main() {
    printf("Enter text (end with EOF):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
