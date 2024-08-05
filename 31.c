#include <stdio.h>
#include <string.h>

#define MAX_LEN 100

void eliminate_left_recursion(const char *production) {
    char non_terminal, new_non_terminal;
    char alpha[MAX_LEN], beta[MAX_LEN];
    char *ptr;
    non_terminal = production[0];
    ptr = strchr(production, '>') + 2;
    if (*ptr == non_terminal) {
        char *alpha_start = ptr;
        char *beta_start = strchr(ptr, '|') + 2;
        size_t alpha_len = strchr(ptr, '|') - ptr - 1;
        strncpy(alpha, alpha_start, alpha_len);
        alpha[alpha_len] = '\0';
        size_t beta_len = strlen(beta_start);
        strncpy(beta, beta_start, beta_len);
        beta[beta_len] = '\0';
        new_non_terminal = non_terminal + 1;
        printf("%c -> %s%c'\n", non_terminal, beta, new_non_terminal);
        printf("%c' -> %s%c' | epsilon\n", new_non_terminal, alpha, new_non_terminal);
    } else {
        printf("%s\n", production);
    }
}

int main() {
    char production[MAX_LEN];

    printf("Enter the production (e.g., A -> Aa | b): ");
    fgets(production, MAX_LEN, stdin);
    
    production[strcspn(production, "\n")] = '\0';

    eliminate_left_recursion(production);

    return 0;
}
