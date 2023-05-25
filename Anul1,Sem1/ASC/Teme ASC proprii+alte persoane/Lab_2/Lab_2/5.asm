bits 32 

global start        

extern exit             
import exit msvcrt.dll   

; a,b,c,d -byte ; e,f,g,h-word
segment data use32 class=data
    a db 2
    b db 3
    e dw 4
    f dw 5
    g dw 6

; (e+f+g)/(a+b)
segment code use32 class=code
    start:
        ; e+f
        mov ax, [e]
        add ax, [f]
        
        ; e+f+g
        add ax, [g]
        
        ; a+b
        mov bl, [a]
        add bl, [b]
        
        ; (e+f+g)/(a+b)
        div byte bl
        
        push    dword 0  
        call    [exit]     
