%{
#include <stdio.h>
#include <stdlib.h>

// Define yywrap with the expected prototype
int yywrap(void) {
    return 1;  // Indicate end of input
}
%}

%%

((http|https|ftp):\/\/[a-zA-Z0-9]{2,}(\.[a-zA-Z]{2,})+(\:[0-9]+)?(\/[a-zA-Z0-9+=?]*)*) {
    printf("\nURL Valid\n");
}

.|\n {
    printf("\nURL Invalid\n");
}

%%

int main() {
    printf("Enter URL: ");
    yylex();
    printf("\n");
    return 0;
}
