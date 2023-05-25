bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10
    b db 20
    c db 5
    d db 40

; our code starts here
segment code use32 class=code
    start:
        ;calculati a+13-c+d-7+b
    
        mov AH , [a] ; AH = a = 10
        add AH , 13 ; AH = a + 13
        sub AH , [c] ; AH = a + 13 - c
        add AH , [d] ; AH = a + 13 - c + d 
        sub AH , 7 ; AH = a + 13 - c + d - 7
        add AH , [b] ; AH = a +13 - c + d -7 + b
        
       
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
