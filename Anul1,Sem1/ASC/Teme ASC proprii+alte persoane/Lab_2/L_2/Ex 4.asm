bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
; a,b,c - byte, d - word
segment data use32 class=data
    ; ...
    a db 4
    b db 7
    c db 5
    d dw 23
    

; our code starts here
; (10*a-5*b)+(d-5*c)
segment code use32 class=code
    start:
        ; ...
        
        ; Calculam 10 * a in AX => AX = 10*a
        mov al, 10
        mul byte [a]
        mov bx, ax ; BX = AX = 10*a
        
        ; Calculam 5 * b in AX = 5 * b
        mov al, 5
        mul byte [b]
        
        ; Calculam (10 * a - 5 * b) = BX - AX
        sub bx, ax ; BX = (10 * a - 5 * b)
        
        ; Calculam 5 * c
        mov al, 5
        mul byte [c] ; AX = 5 * c
        
        ; Calculam d - 5 * c = d - AX
        mov dx, [d]
        sub dx, ax ; DX = (d - 5 * c)
        
        ; Calculam (10 * a - 5 * b) + (d - 5 * c) = BX - DX
        add bx, dx ; Avem raspunsul in BX
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
