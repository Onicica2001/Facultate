bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
; a, b, c, d = word
segment data use32 class=data
    ; ...
    a dw 24
    b dw 50
    c dw 32
    d dw 14

; our code starts here
; (a-c)+(b-d)
segment code use32 class=code
    start:
        ; ...
        
        ; Calculam a - c in AX
        mov ax, [a]
        sub ax, [c]
        
        ;Calculam b - d in DX
        mov dx, [b]
        sub dx, [d]
        
        ; Adunam AX si DX si obtinem rezultatul in AX
        add ax, dx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
