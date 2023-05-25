;a,b,c,d - word
;a-c+d-7+b-(2+d)


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 1000h  ; a = 4096
    b dw 0AAh ;  b =  170
    c dw 0FFFh  ; c = 4095
    d dw  19h ; d = 25 
    
    ; a - c + d - 7 + b - (2 + d) = A2 ; calcule pe un calculator 
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax, [a] ; AX = a
        sub ax, [c] ; AX = AX - c = a - c
        add ax, [d] ; AX = AX + d = a - c + d
        sub ax, 7 ; AX = AX - 7 = a - c + d - 7
        add ax, [b] ; AX = AX + b = a - c + d - 7 + b
        mov bx, 2 ; BX = 2
        add bx, [d] ; BX = BX + d = 2 + d  
        sub ax, bx ;  AX = AX - BX = a - c + d - 7 + b - ( 2 + d) 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
