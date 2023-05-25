#include <stdio.h> 
int CSubsir(char sir1[],char sir2[])
{
    for(int j = 0; sir2[j] != '\0'; j++)
    {
        if( sir1[0] == sir2[j])
        {
            int i = 1;
            int k = j+1;
            while(sir1[i] == sir2[k]&& sir1[i] != '\0' && sir2[k] != '\0')
            {
                i++;
                k++;
            }
            if(sir1[i] == '\0')
                return 1;
        }
    }
    return 0;
}
int run(char sir1[]);
void citireSirC(char sir[]);

//Se citesc mai multe siruri de caractere. Sa se determine daca primul apare ca subsecventa in fiecare din celelalte si sa se dea un mesaj corespunzator.
int main()
{   
    char sir1[150]; 
    int se_afla;
    printf("%s", "Dati primul sir "); 
    scanf("%s", &sir1);
    se_afla = run(sir1);
    if(se_afla == 1)
        printf("Sirul %s se afla in toate celelalte subsiruri", sir1);
    else
        printf("Sirul %s  NU se afla in toate celelalte subsiruri", sir1);
    return 0;
}

void citireSirC(char sir[])
{
    scanf("%s", sir);
}