%{
#include <stdio.h>
#include <stdlib.h>

int num_macros = 0;    // To count #define directives
int num_includes = 0;  // To count #include directives

void count_macro() {
    num_macros++;
}

void count_include() {
    num_includes++;
}
%}

%option noyywrap

%%

"#define"      { count_macro(); }
"#include"    { count_include(); }
[ \t\n]+      { /* Ignore whitespace */ }
.             { /* Ignore other characters */ }

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

    printf("Number of #define directives: %d\n", num_macros);
    printf("Number of #include directives: %d\n", num_includes);

    return 0;
}
