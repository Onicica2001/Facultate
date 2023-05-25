bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 5
    b dw 5
    c dw 100 
    d dw 45

; our code starts here
segment code use32 class=code
    start:
        ;calculati (a+b+b)+(c-d)
    
        mov AX , [a] ; AX = a = 5 
        add AX , [b] ; AX = AX + b = a + b = 5 + 5 = 10
        add AX , [b] ; AX = AX + b = (a + b + b) = 10 + 5 = 15
        mov BX , [c] ; BX = c = 100 
        sub BX , [d] ; BX = (c - d) = 100 - 45 = 55 
        add AX , BX ; AX = AX + BX = (a + b + b) + (c -d) = 15 + 55 = 70
       
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
