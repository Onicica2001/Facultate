bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
; a, b, c, d = bytes
segment data use32 class=data
    ; ...
    a db 10
    b db 5
    c db 6
    d db 14

; our code starts here
; (a-b-b-c)+(a-c-c-d)
segment code use32 class=code
    start:
        ; ...
        
        ; Calculam a - b - b - c in AH
        mov al, [a]
        sub AL, [b]
        sub AL, [b]
        sub AL, [c]
        
        ;Calculam a - c - c - d in AH
        mov ah, [a]
        sub ah, [c]
        sub ah, [c]
        sub ah, [d]
        
        ; Adunam AH cu Al si obtinem rezultatul in AH
        add ah, al
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
