bits 32 

global start 
       
extern exit , printf                     
import exit msvcrt.dll    
import printf msvcrt.dll

extern convert_caracter               

segment data use32 class=data
    s db '10100111b', '01100011b', '00000110b', '00101011b'
    len_s equ $-s
    d times 200 db -1
    rez times 200 db -1

segment code use32 class=code
    start:
        
        mov ecx , len_s
        mov esi , s 
        mov edi , d 
        
        repeta:
        lodsb ; se incarca caracter cu caracter valorile din sirul s declarat in segmentul de date 
        mov bl , al ; salvam in bl o copie a valorii curente din sir pentru a o compara cu valoarea obtinuta in urma conversiei ====> pentru a ne da seama daca caract este '0' sau '1'
        call convert_caracter
        
        cmp al , 0 
        je store_cifra
        
        cmp al , 1 
        je store_cifra
        
        jmp final_loop
        
        store_cifra:
        stosb 
        
        loop repeta
        
        push    dword 0      
        call    [exit]       
