%{
#include <stdio.h>
#include <stdlib.h>

#define NUMBER 1
#define OPERATOR 2

double num1 = 0, num2 = 0;
char op = '\0';

void perform_operation(double num1, char op, double num2);
int yywrap(void);
%}

%%

[0-9]+(\.[0-9]+)? {
    if (op == '\0') {
        num1 = atof(yytext);
    } else {
        num2 = atof(yytext);
    }
    return NUMBER;
}

"+"|"-"|"*"|"/" {
    op = yytext[0];
    return OPERATOR;
}

\n {
    if (op != '\0') {
        perform_operation(num1, op, num2);
    }
    num1 = num2 = 0;
    op = '\0';
}

[ \t]+  // Ignore whitespace

. {
    fprintf(stderr, "Unexpected character: %s\n", yytext);
}

%%

void perform_operation(double num1, char op, double num2) {
    double result;
    switch (op) {
        case '+':
            result = num1 + num2;
            break;
        case '-':
            result = num1 - num2;
            break;
        case '*':
            result = num1 * num2;
            break;
        case '/':
            if (num2 != 0) {
                result = num1 / num2;
            } else {
                fprintf(stderr, "Error: Division by zero\n");
                return;
            }
            break;
        default:
            fprintf(stderr, "Error: Unknown operator %c\n", op);
            return;
    }
    printf("Result: %.2f\n", result);
}

int yywrap(void) {
    return 1; // End of input
}

int main() {
    printf("Enter mathematical expressions (e.g., 5 + 3):\n");
    yylex();
    return 0; // Exit the program
}
