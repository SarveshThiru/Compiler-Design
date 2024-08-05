%{
#include <stdio.h>

int whitespace_count = 0;
int newline_count = 0;

void print_counts() {
    printf("Whitespace characters: %d\n", whitespace_count);
    printf("Newline characters: %d\n", newline_count);
}

%}

%%

[ \t]            { whitespace_count++; }
\n               { newline_count++; }

.                ;

%%
int yywrap() {
    return 1;
}
int main(int argc, char **argv) {
    yylex();
    print_counts();
    return 0;
}
