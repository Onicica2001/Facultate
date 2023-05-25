;30. Se da cuvantul A. Sa se formeze doublewordul B in felul urmator:
;    bitii 0-3 ai lui B sunt bitii 1-4 ai rezultatului A XOR 0Ah
;    bitii 4-11 ai lui B sunt bitii 7-14 ai lui A
;    bitii 12-19 ai lui B au valoarea 0
;    bitii 20-25 ai lui B au valoarea 1
;    bitii 26-31 ai lui C sunt bitii 3-8 ai lui A complementati

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0111011101010111b
    b dd 0

; our code starts here
segment code use32 class=code
    start:
    
        mov  ebx, 0 ; in registrul bx vom calcula rezultatul
        
        ;    bitii 0-3 ai lui B sunt bitii 1-4 ai rezultatului A XOR 0Ah
        mov ax,[a]                       ; ax = 0111011101010111
        xor ax, 0ah                     ; 0ah = 0000000000001010 -> ax = 0111011101011101
        cwde                       
        
        and eax, 00000000000000000000000000011110b       ; zerorizam bitii lui eax din afara intervalului 1-4
        
        mov cl,1
        ror eax,cl                       ; rotim 1 pozitie spre dreapta
        
        or  ebx,eax                       ; bx = 0000000000000000 0000000000001110
        
        ;    bitii 4-11 ai lui B sunt bitii 7-14 ai lui A
        mov ax, [a]
        cwde 
        and eax, 00000000000000000111111110000000b       ; ax = 0111011100000000b
        
        mov cl,3
        ror eax,cl                       ; rotim 3 pozitii spre dreapta
        
        or  ebx,eax 
        
        ;    bitii 12-19 ai lui B au valoarea 0
        
        and ebx, 11111111111100000000111111111111b 
        
        ;    bitii 20-25 ai lui B au valoarea 1
        
        or  ebx, 00000011111100000000000000000000b
        
        ;    bitii 26-31 ai lui C sunt bitii 3-8 ai lui A complementati
        mov ax, [a]
        cwde 
        and eax, 00000000000000000000000111111000b
        
        mov cl, 23
        rol eax,cl                       ; rotim 23 pozitii spre stanga
        
        xor eax, 11111111111111111111111111111111b    ; inversa lui eax 
        add eax, 00000000000000000000000000000001b    ; adun cu 1 eax -> complementara lui A
        
        and eax, 11111100000000000000000000000000b 
        
        or  ebx,eax 
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
