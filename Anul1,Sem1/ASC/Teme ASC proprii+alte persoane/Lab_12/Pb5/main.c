#include <stdio.h> 

unsigned int Operatie(unsigned int a, unsigned int b, unsigned int c) ;

int main()
{
    unsigned int a = 0 ;
    unsigned int b = 0 ;
    unsigned int c = 0 ;
    unsigned int rez = 0 ;
    
    // Se citesc de la tastatura cele 3 numere
    printf("a = ") ;
    scanf("%u", &a) ;
    
    printf("b = ") ;
    scanf("%u", &b) ;
    
    printf("c = ") ;
    scanf("%u", &c) ;
    
    // Se efectueaza calculul operatiei
    rez = Operatie(a, b, c) ;
    
    // Se afiseaza
    printf("Rezultatul operatiei a+b-c este %u", rez) ;
    return 0 ;
    
    
}