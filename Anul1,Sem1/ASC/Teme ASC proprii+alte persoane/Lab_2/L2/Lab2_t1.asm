; exercitii simple : 12/4
bits 32

global start

extern exit
import exit msvcrt.dll


segment data use32 class=data
    
    
segment code use32 class=code
    start:
        mov ax, 12            ; AX= 0000 0000 0000 1100 b
        mov dl, 4             ; DL= 0000 0100 b
        div dl                ; AL= AX/DL= 0000 0011 b   AH=0000 0000 b
        push dword 0          
        call [exit]           
       