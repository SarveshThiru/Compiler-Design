%{
#include <stdio.h>
#include <stdlib.h>

int num_chars = 0;    // To count characters
int num_lines = 0;    // To count lines
int num_words = 0;    // To count words

void count_word(char *str) {
    char *ptr = str;
    while (*ptr) {
        while (*ptr == ' ' || *ptr == '\t') ptr++;  // Skip spaces and tabs
        if (*ptr == '\0' || *ptr == '\n') return;    // End of line or string
        num_words++;
        while (*ptr != ' ' && *ptr != '\t' && *ptr != '\n' && *ptr != '\0') ptr++;  // Skip word
    }
}
%}

%option noyywrap
%start COMMENT

%%

"/*"           { BEGIN(COMMENT); }
<COMMENT>"*/"  { BEGIN(INITIAL); }
<COMMENT>"*"[^/] { /* Skip until end of comment */ }
<COMMENT>[^*]+ { /* Skip characters inside multi-line comments */ }
"//".*         { /* Skip single-line comments */ }
\n             { num_lines++; }
[^ \t\n]+      { num_chars++; count_word(yytext); }
.              { num_chars++; }   // Count other characters

%%

int main() {
    FILE *file = fopen("sample1.c", "r");
    if (!file) {
        perror("fopen");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);

    printf("Number of characters: %d\n", num_chars);
    printf("Number of lines: %d\n", num_lines);
    printf("Number of words: %d\n", num_words);

    return 0;
}
