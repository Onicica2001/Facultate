bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; a,b,c,d - word
segment data use32 class=data
    a dw 30
    b dw 5
    c dw 9
    d dw 6

; (a+b-c)-d
segment code use32 class=code
    start:
        ; a+b
        mov ax, [a]
        add ax, [b]
        
        ; a+b-c
        sub ax, [c]
        
        ; (a+b-c)-d
        sub ax, [d]
    
        push    dword 0   
        call    [exit]     
