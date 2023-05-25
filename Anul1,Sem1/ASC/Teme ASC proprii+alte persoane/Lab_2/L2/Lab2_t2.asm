; a,b,c,d, byte : d-(a+b)-c
bits 32

global start

extern exit
import exit msvcrt.dll


segment data use32 class=data
    a db 1
    b db 2
    c db 3
    d db 10
    
segment code use32 class=code
    start:
        ; a+b
        mov dl, [a]            ; DL= 0000 0001 b
        add dl, [b]             ; DL=DL+b= 0000 0011 b (a+b)
        ; d-(a+b)
        mov al, [d]            ;AL= 0000 1010 bits
        sub al,dl               ; AL= AL-DL= 0000 0111 b d-(a+b)
        ; d-(a+b)-c
        sub al, [c]              ; AL=AL-c= 0000 0100 b
        push dword 0          
        call [exit]           
       