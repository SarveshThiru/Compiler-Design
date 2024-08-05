%{
 #include <stdio.h> // Include standard I/O library for printf
 int positive_count = 0;
 int negative_count = 0;
%}
%%
[+-]?[0-9]+ { 
 int num = atoi(yytext); // Convert matched text to integer
 if (num > 0)
 positive_count++;
 else if (num < 0)
 negative_count++;
 }
. ; // Ignore other characters
%%
int yywrap() {
 return 1; // Indicate that there are no more files to parse
}
int main() {
 yylex(); // Start lexical analysis
 printf("Number of positive numbers: %d\n", positive_count);
 printf("Number of negative numbers: %d\n", negative_count);
 return 0;
}