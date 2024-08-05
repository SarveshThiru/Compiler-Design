%{
#include <stdio.h>
#include <ctype.h>

// Function to print whether an identifier is valid or not
void print_identifier_status(const char *identifier, int valid) {
    if (valid) {
        printf("Valid identifier: %s\n", identifier);
    } else {
        printf("Invalid identifier: %s\n", identifier);
    }
}

%}

%%

[A-Za-z_][A-Za-z0-9_]*  { print_identifier_status(yytext, 1); } // Valid identifier

[^A-Za-z0-9_]  { printf("Invalid identifier: %s\n", yytext); } // Invalid identifier for non-identifier characters

[ \t\n]+        ;  // Ignore spaces, tabs, and newlines

.               { /* Ignore other characters */ }

%%

int yywrap() {
    return 1;
}
int main(int argc, char **argv) {
    yylex();
    return 0;
}
