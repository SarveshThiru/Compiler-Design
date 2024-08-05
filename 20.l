%{
#include <stdio.h>
#include <stdlib.h>

// Function to print HTML tags
void print_tag(const char *tag) {
    printf("HTML Tag: %s\n", tag);
}
%}

%option noyywrap

%%

"<"[^>]+>     { print_tag(yytext); }  // Matches HTML tags enclosed in < and >
[ \t\n]+    { /* Ignore whitespace */ }
.           { /* Ignore other characters */ }

%%

int main() {
    FILE *file = fopen("sample.html", "r");
    if (!file) {
        perror("fopen");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);

    return 0;
}
