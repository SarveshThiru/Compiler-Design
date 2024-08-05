%%
[0-9]+ { printf("Number: %s\n", yytext); }
[a-zA-Z]+ { printf("Word: %s\n", yytext); }
.|\n ;
%%
int yywrap() {
 return 1;
}
int main() {
 yylex();
 return 0;
}