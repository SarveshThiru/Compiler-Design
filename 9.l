%{
#include <stdio.h>
#include <string.h>

int maxLength = 0;
int currentLength = 0;
%}

%%

[a-zA-Z]+    { 
                currentLength = strlen(yytext); 
                if (currentLength > maxLength) {
                    maxLength = currentLength;
                }
            }

\n          { /* ignore newlines */ }

.           { /* ignore other characters */ }

%%

int yywrap() {
    return 1;  // Indicate end of input
}

int main(int argc, char **argv) {
    yylex();
    printf("Length of the longest word: %d\n", maxLength);
    return 0;
}
