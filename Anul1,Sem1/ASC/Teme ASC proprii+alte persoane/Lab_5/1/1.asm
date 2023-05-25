bits 32 

global start        

extern exit               
import exit msvcrt.dll   
 
; Se dau 2 siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel incat fiecare element din D sa reprezinte minumul dintre elementele de pe pozitiile corespunzatoare din S1 si S2
segment data use32 class=data
    s1 db 1, 3, 6, 2, 3, 7
    s2 db 6, 3, 8, 1, 2, 5
    l equ $-s2
    d times l db 0

segment code use32 class=code
    start:
        mov ecx, l
        mov esi, 0
        jecxz sfarsit
        repeta:
            mov al, [s1+esi]
            mov bl, [s2+esi]
            cmp al, bl
            ja caz
            mov [d+esi], al
            jmp cresc
            caz:
                mov [d+esi], bl
            cresc:
                inc esi
            loop repeta
        sfarsit:
        
        push    dword 0     
        call    [exit]      
