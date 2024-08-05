%{
#include <stdio.h>

// Function to print recognized operators
void print_operator(const char *operator) {
    printf("Operator: %s\n", operator);
}

%}

%%

"+"     { print_operator("+"); }
"-"     { print_operator("-"); }
"*"     { print_operator("*"); }
"/"     { print_operator("/"); }

[ \t\n]+;  // Ignore spaces, tabs, and newlines

.       { printf("Unknown character: %s\n", yytext); }

%%
int yywrap() {
    return 1; // End of input
}
int main(int argc, char **argv) {
    yylex();
    return 0;
}
