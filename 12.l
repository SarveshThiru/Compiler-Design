%{
#include <stdio.h>
#include <stdlib.h>

// Define yywrap function
int yywrap(void) {
    return 1;  // Indicate end of input
}

void print_word(const char *word) {
    printf("Word: %s\n", word);
}

void print_operator(const char *op) {
    printf("Relational Operator: %s\n", op);
}
%}

%%

[a-zA-Z_][a-zA-Z_0-9]* {
    print_word(yytext);
}

==|!=|<=|>=|<|> {
    print_operator(yytext);
}

[ \t\n]+  /* Ignore whitespace */

. {
    // Handle unexpected characters
    printf("Unexpected character: %s\n", yytext);
}

%%

int main() {
    printf("Enter input: ");
    yylex();
    return 0;
}
