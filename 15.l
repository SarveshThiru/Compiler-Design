%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void check_email(const char *email);
int yywrap(void);
%}

email_user [a-zA-Z0-9._%+-]+
domain [a-zA-Z0-9.-]+
tld [a-zA-Z]{2,}

%%

{email_user}@{domain}\.{tld} {
    check_email(yytext);
}

. {
    fprintf(stderr, "Invalid email address: %s\n", yytext);
}

%%

void check_email(const char *email) {
    printf("Valid email address: %s\n", email);
}

int yywrap(void) {
    return 1; // End of input
}

int main() {
    printf("Enter email addresses (end with EOF):\n");
    yylex();
    return 0;
}
