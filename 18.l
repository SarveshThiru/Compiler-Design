%{
#include <stdio.h>
#include <stdlib.h>

void print_constant(const char *constant) {
    printf("Constant: %s\n", constant);
}
%}

%option noyywrap

%%

[0-9]+        { print_constant(yytext); }           // Integer literals
[0-9]*\.[0-9]+([eE][-+]?[0-9]+)? { print_constant(yytext); }  // Floating-point literals
\"([^\"\\\n]|\\.)*\" { print_constant(yytext); }   // String literals
[ \t\n]+       { /* Ignore whitespace */ }
.              { /* Ignore other characters */ }

%%

int main() {
    FILE *file = fopen("sample2.c", "r");
    if (!file) {
        perror("fopen");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);

    return 0;
}
