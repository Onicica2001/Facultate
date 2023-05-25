bits 32 

global start        

extern exit              
import exit msvcrt.dll   

segment data use32 class=data
    a dw 0111001000111101b
    b dw 0010100111001111b
    c dd 0

; Se dau cuvintele A si B. Se cere dublucuvantul C:
; bitii 0-5 ai lui C coincid cu bitii 3-8 ai lui A
; bitii 6-8 ai lui C coincid cu bitii 2-4 ai lui B
; bitii 9-15 ai lui C reprezinta bitii 6-12 ai lui A
; bitii 16-31 ai lui C sunt 0
segment code use32 class=code
    start:
        mov bx, 0
        
        ; bitii 0-5 ai lui C coincid cu bitii 3-8 ai lui A
        mov ax, [a]
        and ax, 0000000111111000b
        shr ax, 3
        or bx, ax
        
        ; bitii 6-8 ai lui C coincid cu bitii 2-4 ai lui B
        mov ax, [b]
        and ax, 0000000000011100b
        rol ax, 4
        or bx, ax
        
        ; bitii 9-15 ai lui C reprezinta bitii 6-12 ai lui A
        mov ax, [a]
        and ax, 0001111111000000b
        rol ax, 3
        or bx, ax
        
        ; bitii 16-31 ai lui C sunt 0
        push word 0
        push bx
        pop ebx
        
        mov [c], ebx 
    
        push    dword 0    
        call    [exit]  
