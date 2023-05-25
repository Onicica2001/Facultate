bits 32

global start        

extern exit              
import exit msvcrt.dll    

; a,b,c,d - byte
segment data use32 class=data
    a db 7
    b db 5
    c db 9
    d db 6

; (c+d+d)-(a+a+b)
segment code use32 class=code
    start:
        ; c+d
        mov al, [c]
        add al, [d]
        
        ; c+d+d
        add al, [d]
        
        ; a+a
        mov ah, [a]
        add ah, [a]
        
        ; a+a+b
        add ah, [b]
        
        ; (c+d+d)-(a+a+b)
        sub al, ah
            
        push    dword 0     
        call    [exit]      
