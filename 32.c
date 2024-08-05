#include <stdio.h>
#include <string.h>

#define MAX_LEN 100

void eliminate_left_factoring(const char *production) {
    char non_terminal;
    char prefix[MAX_LEN], remainder1[MAX_LEN], remainder2[MAX_LEN];
    char *ptr;
    char new_non_terminal;

    non_terminal = production[0];
    ptr = strchr(production, '>') + 2; 
    char *pipe_pos = strchr(ptr, '|');
    if (pipe_pos == NULL) {
        printf("%s\n", production);
        return;
    }

    size_t prefix_len = 0;
    while (ptr[prefix_len] != '\0' && ptr[prefix_len] != '|' && ptr[prefix_len] == ptr[prefix_len + 1]) {
        prefix_len++;
    }
    strncpy(prefix, ptr, prefix_len);
    prefix[prefix_len] = '\0';

    // Extract remainders
    ptr += prefix_len;
    if (*ptr == '|') {
        ptr++;
    }
    strcpy(remainder1, ptr);

    pipe_pos = strchr(remainder1, '|');
    if (pipe_pos != NULL) {
        *pipe_pos = '\0'; // Separate the first and second remainder
        strcpy(remainder2, pipe_pos + 1);
    } else {
        remainder2[0] = '\0';
    }
    new_non_terminal = non_terminal + 1;
    printf("%c -> %s%c'\n", non_terminal, prefix, new_non_terminal);
    printf("%c' -> %s | %s\n", new_non_terminal, remainder1, remainder2);
}

int main() {
    char production[MAX_LEN];

    printf("Enter the production (e.g., A -> Ab | Ac | Ad): ");
    fgets(production, MAX_LEN, stdin);
    production[strcspn(production, "\n")] = '\0';

    eliminate_left_factoring(production);

    return 0;
}
