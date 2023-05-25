#include <stdio.h>

void afisare(int);

int main()
{
    printf("Decimal  Octal  ASCII\n");
    printf("---------------------\n");
    for (int i = 32; i <= 126; ++i) afisare(i);
    
    return 0;
}