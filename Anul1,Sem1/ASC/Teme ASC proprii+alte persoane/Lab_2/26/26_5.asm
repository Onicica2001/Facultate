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
    e dw 10
    g dw 12
    b db 4
    c db 6
    m db 2

; our code starts here
; (e + g - 2 * b) / c
segment code use32 class=code
    start:
        ; ...
    mov bx, [e] ; BX = e = 10
    add bx, [g] ; BX = BX + g = 10 + 12 = 22
    mov al, [b] ; AL = b = 4
    mul byte [m] ; AX = 2 * b = 8
    sub bx, ax ; BX = BX - AX = 22 - 8 = 14
    mov ax, bx ; AX = BX = 14
    div byte [c] ; AH = AX / c = 2, AL = AX % c = 2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
