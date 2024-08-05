%{
#include <stdio.h>
#include <stdlib.h>

// Function to handle single-line and block comments
void handle_comment() {
    // No operation needed here, comments are just ignored
}
%}

%option noyywrap

%%

\/\/.*                     { /* Ignore single-line comments */ }
\/\*[^*]*\*+([^/*][^*]*\*+)*\/ { /* Ignore block comments */ }
\n                        { /* Print newline */ putchar('\n'); }
[ \t]+                    { /* Ignore spaces and tabs */ }
.                         { /* Copy any other character */ putchar(yytext[0]); }

%%

int main() {
    FILE *file = fopen("sample3.c", "r");
    if (!file) {
        perror("fopen");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);

    return 0;
}
