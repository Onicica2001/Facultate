;a,b,c,d - word
;b-(b+c)+a
bits 32 
global start        


extern exit               
import exit msvcrt.dll   
segment data use32 class=data
    a dw 15
    b dw 10
    c dw 5
segment code use32 class=code
    start:
        ; b+c
        mov ax, [b] ;ax=b
        add ax, [c]; ax=ax+c=b+c
        ;b-(b+c)
        mov bx, [b] ;bx=b 
        sub bx, ax ;bx=bx-ax=b-(b+c) 
        ;b-(b+c)+a
        add bx, [a] ; bx=bx+a=b-(b+c)+a 
        ;rezultetul final este in bx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
