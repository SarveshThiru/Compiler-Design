%{
int vow_count=0;
int const_count=0;
%}
%%
[aeiouAEIOU] {vow_count++;}
[a-zA-Z] {const_count++;}
%%
int yywrap(){}
int main()
{
printf("enter the string of vowels and consonents:\n");
yylex();
printf("number of vowels : %d ,number of consonentsare:%d",vow_count,const_count);
}