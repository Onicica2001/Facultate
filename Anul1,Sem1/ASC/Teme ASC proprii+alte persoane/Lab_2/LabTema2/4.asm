;a,b,c - byte, d - word
;(50-b-c)*2+a*a+d
bits 32 
global start        


extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    a db 5
    b db 10
    c db 15
    d dw 20

; our code starts here
segment code use32 class=code
    start:
        ;50-b
        mov dh, 50 ;dh=50
        sub dh, [b] ;dh=50-b
        ;50-b-c
        sub dh, [c] ;dh=50-b-c
        ;(50-b-c)*2
        mov al,2 ;al=2
        mul dh   ;ax=al*dh=2*(50-b-c)
        mov bx, ax ;bx=ax
        ;a*a
        mov al, [a] ;al=a*a
        mul al      ;ax=al*al=a*a
        ;(50-b-c)*2+a*a
        add bx,ax ;bx=bx+ax=(50-b-c)*2+a*a
        ;(50-b-c)*2+a*a+d
        add bx, [d] ;bx=bx+d=(50-b-c)*2+a*a+d
        ;rezultatul final este in bx(bl)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
