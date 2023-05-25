bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the) variables needed by our program)
segment data use32 class=data

    a db 45
    b db 10
    c db 6 

; our code starts here
segment code use32 class=code
    start:
        ;calculati (a+b)/2 +(10-a/c)+b/4
            
        mov AL , [a] ; AL = a = 45 
        add AL , [b] ; AL = (a + b) = 45 + 10 = 55 
        sub AH , AH ; Clear AH
        mov BH , 2 ; BH = 2 
        div BH ; (a+b)/2   AX : BH = 55 : 2 = 27 r 1 ===> AL = 27 SI AH = 1
        
        mov BH , AL ; BH = AL = 27 (a+b)/2
        mov BL , [c] ; BL = c = 6
        sub AH , AH ; Clear AH
        mov AL , [a] ; AL = a = 45
        div BL ; a/c AX : BL = 45 : 6 = 7 r 3 ===> AL = 7 SI AH = 3 
        mov AH , 10
        sub AH , AL ; AH = AH - AL = 10 - 7 = 3 (10-a/c)
        add BH , AH ; BH = BH + AH = 27 + 3 = 30 (a+b)/2 + (10-a/c)
        
        mov AL , [b] ; AL = b = 10
        sub AH , AH ; Clear AH
        mov CH , 4 
        div CH ; AX : CH = 10 : 4 = 2 R 2 ===> AL = 2 SI AH = 2 (b/4)
        
        add BH , AL ; BH = BH + AL = (a+b)/2 + (10-a/c) + b/4 = 27 + 3 + 2 = 32
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
