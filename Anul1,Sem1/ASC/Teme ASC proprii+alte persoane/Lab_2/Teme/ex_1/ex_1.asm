bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 4
    b db 4

; our code starts here
segment code use32 class=code
    start:
        
        ;calculati 4*4
        
        mov AL , [b] ; AL = b = 4
        mov DH , [a] ; DH = a = 4 
        mul DH ; AX = AL * DH = b * a = 4 * 4 = 16
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
