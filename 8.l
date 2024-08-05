%%
[aeiouAEIOU][a-zA-Z]* { printf("String starting with vowel: %s\n", yytext); }
.|\n ;
%%
int yywrap() {
 return 1;
}
int main() {
 yylex();
 return 0;
}