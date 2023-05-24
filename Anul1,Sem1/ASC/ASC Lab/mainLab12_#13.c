#include <stdio.h>
#include <string.h>

//Se dau trei siruri de caractere. Sa se afiseze cel mai lung sufix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.

int minim(int a, int b)
{
    if(a < b)
        return a;
    return b;

}

char common_suffix(char sir1[],char sir2[],int lungime_minima,char rezultat[]);

int main()
{
    char s1[101] = "cevaananas";
    char s2[101] = "albounas";
    char s3[101] = "frunas";
    char rezultat[101]="";
    int lungime_minima;
    int ls1 = strlen(s1);
    int ls2 = strlen(s2);
    int ls3 = strlen(s3);
    
    // Ne ocupam de s1 cu s2
    lungime_minima = minim(ls1,ls2);
    common_suffix(s1+ls1-lungime_minima,s2+ls2-lungime_minima,lungime_minima,rezultat);
    printf("Sufixul maxim comun sirului 1 si 2 este %s \n",rezultat);
    
    // Ne ocupam de s1 cu s3
    lungime_minima = minim(ls1,ls3);
    //rezultat=common_suffix(s1+ls1-lungime_minima,s3+ls3-lungime_minima,lungime_minima);
    common_suffix(s1+ls1-lungime_minima,s3+ls3-lungime_minima,lungime_minima,rezultat);
    printf("Sufixul maxim comun sirului 1 si 3 este %s \n",rezultat);
    
    // Ne ocupam de s2 cu s3
    lungime_minima = minim(ls2,ls3);
    //rezultat=common_suffix(s1+ls1-lungime_minima,s3+ls3-lungime_minima,lungime_minima);
    common_suffix(s1+ls1-lungime_minima,s3+ls3-lungime_minima,lungime_minima,rezultat);
    printf("Sufixul maxim comun sirului 2 si 3 este %s",rezultat);
}  