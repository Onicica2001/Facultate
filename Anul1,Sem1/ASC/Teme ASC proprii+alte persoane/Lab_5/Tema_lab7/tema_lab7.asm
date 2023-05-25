bits 32 
global start        

extern exit               
import exit msvcrt.dll   
segment data use32 class=data
    ;Se da un sir de octeti S. Sa se determine maximul elementelor de pe pozitiile pare si minimul elementelor de pe pozitiile impare din S
    ;S: 1, 4, 2, 3, 8, 4, 9, 5
    ;max_poz_pare: 9
    ;min_poz_impare: 3
    
    sir db 1, 4, 2, 3, 8, 4, 9, 5       ;declar sirul
    lungime equ $-sir                   ;lungime - lungimea sirului
    max_poz_pare db 0
    min_poz_impare db 0                 ;variabile pentru maxim si minim

    
segment code use32 class=code
    start:
        mov al, [sir+0]
        mov [max_poz_pare], al
        mov al, [sir+1]
        mov [min_poz_impare], al        ;initializez maximul si minimul cu primul element par, respectiv impar
        
        mov ecx, lungime                ;mut lungimea in ecx pentru a realiza bucla de cate ori e necesar
        jecxz final
        
        mov esi, 0                      ;i = 0
        
    repeta:
        mov al, [sir+esi]               ;AL = sir[i]
           
        ;xxxxxxx0 AND
        ;00000001
        ;--------
        ;00000000 -> ZF = 1 par, ZF = 0 impar
        
        test esi, 01h                   ;testez daca numarul e par sau impar
        jz par
        
        ;numarul e impar
        cmp al, [min_poz_impare]        ;verific daca numarul din sir e mai mic decat minimul actual
        jl mai_mic
        jmp continuare
    
    mai_mic:
        mov [min_poz_impare], al        ;actualizez minimul
        jmp continuare
        
    par:  
        cmp al, [max_poz_pare]          ;verific daca numarul din sir e mai mare decat maximul actual
        jg mai_mare
        jmp continuare
    
    mai_mare:
        mov [max_poz_pare], al          ;actualizez maximul
    
    continuare:
    
    inc esi                             ;i = i + 1
    
    loop repeta     
    
    final:
    
        push    dword 0     
        call    [exit]       