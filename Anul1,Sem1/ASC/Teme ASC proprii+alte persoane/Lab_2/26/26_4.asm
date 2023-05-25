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
    a db 34
    b db 23
    c db 12
    d dw 5 
    m db 5

; our code starts here
; d + [(a + b) * 5 - (c + c) * 5] 
segment code use32 class=code
    start:
        ; ...
    mov al, [a] ; AL = a = 34
    add al, [b] ; AL = AL + b = 34 + 23 = 57
    mul byte [m] ; AX = AL * m = 57 * 5 = 285
    mov bx, ax ; BX = AX = 285
    mov ax, [c] ; AX = c = 12
    add ax, [c] ; AX = AX + c = 24
    mul byte [m] ; AX = AX * m = 120
    sub bx, ax ; BX = BX - AX = 285 - 120 = 165
    mov ax, bx ; AX = BX = 165
    add ax, [d] ; AX = AX + d = 165 + 5 = 170
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
