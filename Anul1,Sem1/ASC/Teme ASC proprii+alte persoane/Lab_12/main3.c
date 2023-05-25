/*
Se dau doua siruri continand caractere
Sa se calculeze si sa se afiseze rezultatul concatenarii tuturor caracterelor tip cifra zecimala din cel de-al doilea sir dupa cele din primul sir si invers, rezultatul concatenarii primului sir dupa al doilea.
*/

#include <stdio.h>


int asmC(char sir1[],char sir2[], char sirRez[]);

int main()
{
   char strRez1[50] = "";
   char strRez2[50] = "";
   char str1[] = "Ada2002";
   char str2[] = "16Miau01";
   int lenStrRez = 0;
   
   printf("Buna ziua \n"); 
   printf("\nPrimul sir este : %s", str1);
   printf("\nAl doilea sir este : %s \n", str2);
   lenStrRez = asmC(str2, str1, strRez1);
   printf("\nPrimul sir obtinut este : %s", strRez1);

   lenStrRez = asmC(str1, str2, strRez2);
   printf("\nAl doilea sir obtinut este  : %s", strRez2);
    
   return 0;
}
