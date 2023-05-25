#include <stdio.h>
#include <string.h>

void concatenare(char, char);

///6. Se citesc trei siruri de caractere. Sa se determine si sa se afiseze rezultatul concatenarii lor.

int main()
{
    char sir1[101], sir2[101], sir3[101];
    printf("Primul sir: ");
    scanf("%s",sir1);
    printf("Al doilea sir: ");
    scanf("%s",sir2);
    printf("Al treilea sir: ");
    scanf("%s",sir3);
    printf("Sirul rezultat:");
    concatenare(sir1,sir2,sir3);
    return 0;
}
