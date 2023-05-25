/*++
9.Se cere sa se citeasca de la tastatura un sir de numere, date in baza 16 (se citeste de la tastatura un sir de caractere si in memorie trebuie stocat un sir de numere). Sa se afiseze valoarea zecimala a nr atat ca numere fara semn cat si ca numere cu semn.
--*/

#include <stdio.h>

int i,j,n;
int nrBaza16[10];
char sir[100];
int nrCuSemn, nrFaraSemn;
    
int afisare10(int len,int nrBaza16[]);

int main()
{
    printf("Introduceti numerele in baza 16 separate printr-un spatiu: ");
    scanf("%s",sir);
    
    n=strlen(sir);

    for(i=0; i<n; i++)
    {
        j=0;
        if(sir[i]!=' ')            //luam numarul introdus de tip char caracter cu caracter pana la intalnirea caracterului ' ' pentru a il transforma intr-un numar de tip int 
        {
            if(sir[i]=='a')
                nrBaza16[j]=10;
            else if(sir[i]=='b')
                nrBaza16[j]=11;
            else if(sir[i]=='c')
                nrBaza16[j]=12;
            else if(sir[i]=='d')
                nrBaza16[j]=13;
            else if(sir[i]=='e')
                nrBaza16[j]=14;
            else if(sir[i]=='f')
                nrBaza16[j]=15;
            else
                nrBaza16[j]=sir[i]-'0';
            
            j++;
        }
        else
        {
            nrFaraSemn=afisare10(j,nrBaza16[10]);
            if(nrBaza16[0]>=8)
                nrCuSemn=-1;
            else
                nrCuSemn=1;
            
            nrCuSemn=nrCuSemn*(256-nrFaraSemn);
            printf("Valoarea numarului fara semn este %u, iar cu semn este %d",nrFaraSemn,nrCuSemn);
            
        }
    }

    return 0;
}
