#include <stdio.h>
#include <string.h>

int intercalare(int,char[],char[], char[]);

// Se dau doua siruri de caractere de lungimi egale. Se cere sa se calculeze si sa se afiseze rezultatele intercalarii literelor, pentru cele doua intercalari posibile (literele din primul sir pe pozitii pare, respectiv literele din primul sir pe pozitii impare).
 
int main()
{
    int nr,n;
    char s1[]="aaaa1111";
    char s2[]="bbbb2222";
    char rez[50]="";
    n=strlen(s1);
    nr = intercalare(n,s1,s2,rez);
    printf("Primul sir rezultat: %s",rez);
    nr = intercalare(n,s2,s1,rez);
    printf("\nAl doilea sir rezultat: %s",rez);
	return 0;
}