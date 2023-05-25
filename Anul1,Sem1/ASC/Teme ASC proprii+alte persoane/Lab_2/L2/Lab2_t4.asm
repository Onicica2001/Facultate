; a,b,c byte d word: [(a-b)*3+c*2]-d
bits 32

global start

extern exit
import exit msvcrt.dll


segment data use32 class=data
       a db 10
       b db 5
       c db 5
       d dw 20
    
segment code use32 class=code
    start:
        ; a-b
        mov al, [a]                 ; AL = 0000 1010 b
        sub al, [b]                 ; AL = AL-b = 0000 0101 b
        ; (a-b)*3
        mov bl, 3                    ; BL = 0000 0011 b
        mul byte bl                 ; AX = AL*3 = 0000 0000 0000 1111 b
        mov dx, ax                  ; DX = 0000 0000 0000 1111 b
        ; c*2
        mov al, [c]                 ; AL = 0000 0101 b
        mov bl, 2                    ; BL = 0000 0010 b
        mul byte bl                 ; AX = 0000 0000 0000 1010 b 
        ; (a-b)*3+c*2
        add ax, dx                  ; AX = AX+DX=c*2+(a-b)*3=0000 0000 0001 1001 b
        ; [(a-b)*3+c*2]-d
        sub ax, [d]                 ; AX = AX-d = 0000 0000 0000 0101 b
        push dword 0          
        call [exit]           
       