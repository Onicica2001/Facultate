bits 32

global start        

extern exit     
import exit msvcrt.dll   

; a,b,c - byte ; d - word
segment data use32 class=data
    a db 2
    b db 3
    c db 4
    d dw 5

; [100-10*a+4*(b+c)]-d
segment code use32 class=code
    start:
        ; b+c
        mov al, [b]
        add al, [c]
        
        ; 4*(b+c)
        mov ah, 4
        mul ah
        
        mov bx, ax
        
        ; 10*a
        mov al, [a]
        mov ah, 10
        mul ah
        
        ; 100-10*a
        mov cx, 100
        sub cx, ax
        
        ; 100-10*a+4*(b+c)
        add bx, cx
        
        ; [100-10*a+4*(b+c)]-d
        sub bx, [d]
    
        push    dword 0     
        call    [exit]   