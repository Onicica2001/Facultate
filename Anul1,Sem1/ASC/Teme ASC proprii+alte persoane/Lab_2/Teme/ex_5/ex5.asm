bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 15
    e dw 20 
    f dw 5 

; our code starts here
segment code use32 class=code
    start:
        
        ;calculati a*a-(e+f)
        
        ;a*a
        
        mov AL , [a] ; AL = a = 15 
        mov BH , [a] ; BH = a = 15
        mul BH ; AX = AL * BH = a * a = 225
        
        ;(e+f)
        
        mov BX , [e] ; BX = e = 20 
        mov CX , [f] ; CX = f = 5 
        add BX , CX ; BX = BX + CX = 20 + 5 = 25
        
        ;a*a-(e+f)
        
        sub AX , BX ; AX = AX - BX = 225 - 25 = 200
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
