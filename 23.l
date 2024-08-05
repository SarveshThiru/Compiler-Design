%{
#include <stdio.h>
#include <stdlib.h>

int lineno = 1;

void print_token(const char *type, const char *value) {
    printf("%d: %s %s\n", lineno, type, value);
}
%}

%option noyywrap

%%
[ \t]+          {}
\n              { lineno++; }

"int"|"float"|"char"|"if"|"else"|"for"|"while"|"return" {
    print_token("keyword", yytext);
}
[a-zA-Z_][a-zA-Z0-9_]* {
    print_token("identifier", yytext);
}
[0-9]+ {
    print_token("integer literal", yytext);
}
\"([^\"\\\n]|\\.)*\" {
    print_token("string literal", yytext);
}
"+"|"-"|"*"|"/"|"%"|"="|"!"|"<"|">"|"<="|">="|"=="|"!="|"&&"|"||" {
    print_token("operator", yytext);
}

";"|"("|")"|"{"|"}"|"["|"]"|"," {
    print_token("punctuation", yytext);
}

"//".*          {}
"/*"([^*]|\*+[^/*])*\*+"/" {}
.               { print_token("unexpected character", yytext); }

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
