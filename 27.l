%{
#include <stdio.h>
#include <stdlib.h>

// Function to print comment status
void print_comment_status(const char *status) {
    printf("%s\n", status);
}

// Define yywrap function
int yywrap() {
    return 1; // End of input
}
%}

%%

"//".*[^\\n]    { print_comment_status("Single-line comment detected"); }

"/*"([^*]|\*+[^/])*\*+"/" { print_comment_status("Multi-line comment detected"); }

[ \t\n]+         ;  // Ignore spaces, tabs, and newlines

.                { printf("Non-comment line detected\n"); }

%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}
