/* Se dau trei siruri de caractere. Sa se afiseze cel mai lung prefix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma. */

#include <stdio.h>

char sir1[] = "abcde";
char sir2[] = "abcef";
char sir3[] = "abpop";

void longestPrefix(char sir1[], char sir2[]);

int main() 
{
    printf("Prima pereche:\n");
    longestPrefix(sir1, sir2);
    printf("\nA doua pereche:\n");
    longestPrefix(sir1, sir3);
    printf("\nA treia pereche:\n");
    longestPrefix(sir2, sir3);
    return 0;
}