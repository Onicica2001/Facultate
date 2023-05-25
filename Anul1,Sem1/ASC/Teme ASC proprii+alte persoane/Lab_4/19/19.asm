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
    a dw  0011101110001000b
    b dd 0
;19.
;Se da un cuvant A. Sa se obtina dublucuvantul B astfel:
;bitii 28-31 ai lui B sunt 1;
;bitii 24- 25 si 26-27 ai lui B sunt bitii 8-9 ai lui A
;bitii 20-23 ai lui B sunt bitii 0-3 inversati ca valoare ai lui A ;
;bitii 16-19 ai lui B sunt biti de 0
;bitii 0-15 ai lui B sunt identici cu bitii 16-31 ai lui B.
segment code use32 class=code
    start:
    
        mov bx, 0
        mov cx, 0   ; CX:BX = 0
        or cx, 1111000000000000b    ;bitii 28-31 ai lui B sunt 1;

        mov ax, [a]
        and ax, 0000001100000000b   ;izolare bitii de la 8-9 ai lui a 
        or cx, ax 
        rol ax, 2
        or cx, ax 
        
        mov ax, 0
        mov ax, [a] 
        not ax
        and ax, 0000000000001111b   ;izolare bitii de la 0-3 ai lui a
        rol ax, 4
        or cx, ax                   ;bitii 20-23 ai lui B sunt bitii 0-3 inversati ca valoare ai lui A
                                    ;bitii 16-19 ai lui B sunt biti de 0
        
        or bx, cx                   ;bitii 0-15 ai lui B sunt identici cu bitii 16-31 ai lui B.
        
        mov [b], bx
        mov [b+2], cx               ; dword-ul b 
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
