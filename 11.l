%{
#include <stdio.h>
#include <stdlib.h>

// Define yywrap with the expected prototype
int yywrap(void) {
    return 1;  // Indicate end of input
}

void validate_date(const char *date) {
    printf("Valid DOB: %s\n", date);
}

void print_invalid_date(const char *date) {
    printf("Invalid DOB: %s\n", date);
}
%}

%%

([0-9]{4})-([0-9]{2})-([0-9]{2}) {
    int year = atoi(yytext);
    int month = atoi(yytext + 5);
    int day = atoi(yytext + 8);

    // Basic validation of date components
    if (month >= 1 && month <= 12) {
        int days_in_month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        // Check for leap year
        if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
            days_in_month[1] = 29;
        }

        if (day >= 1 && day <= days_in_month[month - 1]) {
            validate_date(yytext);
        } else {
            print_invalid_date(yytext);
        }
    } else {
        print_invalid_date(yytext);
    }
}

.|\n {
    // Ignore any text that doesn’t match the date format
}

%%

int main() {
    printf("Enter DOB in YYYY-MM-DD format: ");
    yylex();
    return 0;
}
