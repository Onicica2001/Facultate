

#include <stdio.h>

int transformare(int a);
/*{
    int sum=0;
    sum=a%10+(a/10%10)*2+(a/100%10)*4+(a/1000)*8;
    return sum;
}*/

//11. Se citeste de la tastatura un sir de mai multe numere in baza 2. Sa se afiseze aceste numere in baza 16.

int main()
{
    int vec[100];
    int vec2[10];
    int i=0;
    int nr;
    char val;
    scanf("%d",&nr);
    while(nr!=0)
    {
        int j=0;
        val=0;
        while(nr>9999)
        {
            int nr1=nr%10000;
            nr=nr/10000;
            val=transformare(nr1);
            vec2[j]=val;
            j+=1;
            
        }
        char val3[250];
        int nr1=nr%10000;
        int y=0;
        val=transformare(nr1);
        if(val==10)
            val3[y]='A';
        if(val==11)
            val3[y]='B';
        if(val==12)
            val3[y]='C';
        if(val==13)
            val3[y]='D';
        if(val==14)
            val3[y]='E';
        if(val==15)
            val3[y]='F';
        if(val<=9)
            val3[y]=val+'0';
       
 
        y=1;
        for(int k=j-1;k>=0;k=k-1)
        {
            if(vec2[k]==10)
                val3[y]='A';
            if(vec2[k]==11)
                val3[y]='B';
            if(vec2[k]==12)
                val3[y]='C';
            if(vec2[k]==13)
                val3[y]='D';
            if(vec2[k]==14)
                val3[y]='E';
            if(vec2[k]==15)
                val3[y]='F';
            if(vec2[k]<=9)
                val3[y]=vec2[k]+'0';
            
            y+=1;
           
        }
        val3[y]='\0';
        
        printf("%s ",val3);
        memset(vec2,0,sizeof(vec2));
        scanf("%d", &nr);
    }
    
    


    return 0;
}
