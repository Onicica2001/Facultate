bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; ex 24
;Se da dublucuvantul M. Sa se obtina dublucuvantul MNew astfel:
;bitii 0-3 a lui MNew sunt identici cu bitii 5-8 a lui M
;bitii 4-7 a lui MNew au valoarea 1
;bitii 27-31 a lui MNew au valoarea 0
;bitii 8-26 din MNew sunt identici cu bitii 8-26 a lui M
segment data use32 class=data
    M dd 10010011100111000111000111000110b
    MNew dd 0

; our code starts here
segment code use32 class=code
    start:
        mov EBX, 0       ; in registrul EBX calculez rezultatul
                        ;bitii 0-3 a lui MNew sunt identici cu bitii 5-8 a lui M
        mov EAX, [M] 
                        ;EAX = 10010011100111000111000111000110
       and EAX,00000000000000000000000111100000b
                        ;      10010011100111000111000111000110 and
                        ;      00000000000000000000000111100000 
                        ;EAX = 00000000000000000000000111000000
        mov cl, 5
        ror EAX, CL 
                        ;EAX = 00000000000000000000000000001110
                        ;EBX = 00000000000000000000000000000000
        or EBX, EAX     ;EBX = 00000000000000000000000000001110
        
        ;bitii 4-7 a lui MNew au valoarea 1
                        ;EBX = 00000000000000000000000000001110
        or EBX, 00000000000000000000000011110000b
                        ;EBX = 00000000000000000000000011111110
        
        ;bitii 27-31 a lui MNew au valoarea 0
        and EBX,00000111111111111111111111111111b
                        ;       00000000000000000000000011111110 and 
                        ;       00000111111111111111111111111111
                        ; EBX = 00000000000000000000000011111110 
        
        
        ;bitii 8-26 din MNew sunt identici cu bitii 8-26 a lui M
        mov EAX, [M]
        and EAX,00000111111111111111111100000000b
                        ;       10010011100111000111000111000110 and
                        ;       00000111111111111111111100000000
                        ; EAX = 00000011100111000111000100000000
        or EBX, EAX 
                        ;       00000000000000000000000011111110 or  
                        ;       00000011100111000111000100000000
                        ; EBX = 00000011100111000111000111111110  
        mov [MNew], EBX 
                        ;MNew = 00000011100111000111000111111110
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
