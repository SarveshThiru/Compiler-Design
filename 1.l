%{
 int capital_count = 0;
%}
%%
[A-Z][A-Za-z]*[^a-z] { capital_count++; } // Matches words starting with a capital letter
. ; // Ignore other characters
%%
int yywrap() {
 return 1; // Indicate that there are no more files to parse
}
int main() {
 yylex();
 printf("Number of capital words: %d\n", capital_count);
 return 0;
}