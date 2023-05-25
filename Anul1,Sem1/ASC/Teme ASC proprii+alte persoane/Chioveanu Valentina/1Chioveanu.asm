bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; Se da un sir de dublucuvinte. Sa se obtina sirul format din octetii superiori ai cuvitelor superioare din elementele sirului de dublucuvinte care sunt divizibili cu 3.
segment data use32 class=data
    s dd 12345678h, 1A2B3C4Dh, 0FE98DC76h
    len equ ($-s)/4
    trei db 3
    d times len db 0

segment code use32 class=code
    start:
        mov ecx, len
        jecxz final
        
        cld
        mov esi, s
        mov edi, d
        
        repeta:
            lodsw ; AX=cuvantul inferior
            lodsw ; AX=cuvantul superior
            shr ax, 8 ; mutam partea superioara din AX pe bitii 0-7
            
            mov bl, al
            
            div byte[trei] ; verificam daca e divizibil cu 3
            cmp ah, 0
            
            jnz nu_adauga
            mov al, bl
            stosb ; daca e divizibil cu 3, il adaugam in d
        
        nu_adauga:
        loop repeta
        
    final:
        push    dword 0     
        call    [exit]     
