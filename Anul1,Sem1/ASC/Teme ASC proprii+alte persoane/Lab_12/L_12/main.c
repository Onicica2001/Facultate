#include <stdio.h>

int afiseaza_baza16(int);
int afiseaza_baza2(int);

int main() {
   // Se da un sir de numere. Sa se afiseze valorile in baza 16 si in baza 2.

   int v[5] = {10, 2, 46, 6, 10};

   for(int i = 0; i < 5; i ++)
   {
        afiseaza_baza16(v[i]);
        printf("\n");
   }
   
   printf("\n");

   for(int i = 0; i < 5; i ++)
   {
        afiseaza_baza2(v[i]);
        printf("\n");
   }

   return 0;
}
