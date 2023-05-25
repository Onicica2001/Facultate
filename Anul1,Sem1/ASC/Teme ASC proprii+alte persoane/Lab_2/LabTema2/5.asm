;a,b,c,d-byte, e,f,g,h-word
;[(a+b+c)*2]*3/g

bits 32 
global start        


extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    a db 5
    b db 10
    c db 15
    g dw 20

; our code starts here
segment code use32 class=code
    start:
        ;a+b 
        mov dh, [a] ;dh=a
        add dh, [b] ;dh=a+b
        ;a+b+c
        add dh, [c] ;dh=(a+b)+c
        ;(a+b+c)*2
        mov al,2 ;al=2
        mul dh ;ax=dh*al=(a+b+c)*2
        ;[(a+b+c)*2]*3
        mov bx,ax ;bx=ax=(a+b+c)*2
        mov ax,3 ;ax=3
        mul bx; dx:ax = ax*bx=[(a+b+c)*2]*3
        ;[(a+b+c)*2]*3/g
        push dx
        push ax
        pop eax ;eax=[(a+b+c)*2]*3
        div word [g]; dx:ax=[(a+b+c)*2]*3/g
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
