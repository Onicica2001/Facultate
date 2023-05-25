bits 32 
global start        

extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    a dw 1100011000100100b
    b dw 1001010010110111b
    c dw 1100011110000100b
;problema31
; our code starts here
segment code use32 class=code
    start:
        mov ax, 0
        mov bx, [a]
        and bx, 0111110000000000b
        or ax, bx
        mov bx, [b]
        and bx, 0000001111100000b
        or ax, bx
        mov bx, [c]
        and bx, 0000000000011111b
        or ax, bx   
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
