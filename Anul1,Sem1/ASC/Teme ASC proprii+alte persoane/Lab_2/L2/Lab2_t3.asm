; a,b,c,d  word : b+a-(4-d+2)+c+(a-b)
bits 32

global start

extern exit
import exit msvcrt.dll


segment data use32 class=data
    a dw 10
    b dw 5
    c dw 3
    d dw 1
    
segment code use32 class=code
    start:
        ; b+a
        mov ax, [b]             ; AX=0000 0000 0000 0101 b
        add ax, [a]             ; AX=AX+b= 0000 0000 0000 1111 b
        ; 4-d
        mov dx, 4               ; DX=0000 0000 0000 0100 b
        sub dx,[d]              ; DX=DX-d=0000 0000 0000 0011 b
        ; 4-d+2
        add dx, 2               ; DX=DX+2=0000 0000 0000 0101 b
        ;b+a-(4-d+2)
        sub ax, dx              ; AX=AX-DX=0000 0000 0000 1010 b
        ;b+a-(4-d+2)+c
        add ax, [c]             ; AX=AX+c=0000 0000 0000  1101 b
        ; a-b
        mov dx, [a]             ; DX=0000 0000 0000 1010 b
        sub dx, [b]             ; DX=DX-b=0000 0000 0000 0101 b
        ;b+a-(4-d+2)+c+(a-b)
        add ax, dx              ; AX=AX+DX=0000 0000 0001 0010 b
        push dword 0          
        call [exit]           