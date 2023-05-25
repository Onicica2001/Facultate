;Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
;a,b,c,d - word
;(d-c)+(b+b-c-a)+d
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 
    a dw 2
    b dw 5
    c dw 6
    d dw 7

; our code starts here
segment code use32 class=code
    start:
        ;
         mov AX,[d]; AX=d
         sub AX,[c]; AX=AX-c=d-c
         mov BX,[b]; BX=b
         add BX,[b]; BX=BX+b=b+b
         sub BX,[c]; BX=BX-c=b+b-c
         sub BX,[a]; BX=BX-a=b+b-c+a
         add AX,BX ; AX=AX+BX=(d-c)+(b+b-c+a)
         add AX,[d]; AX=AX+d=(d-c)+(b+b-c-a)+d
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
