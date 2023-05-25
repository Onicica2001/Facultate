bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Se dau 2 siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel incat fiecare element din D sa reprezinte suma dintre elementele de pe pozitiile corespunzatoare din S1 si S2
segment data use32 class=data
    s1 db 1, 2, 3, 4, 5
    l_s1 equ $-s1 
    s2 db 3, 4, 5, 6, 7
    l_s2 equ $-s2 
    d times l_s1+l_s2 db 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, l_s1
        mov esi, 0
        jecxz Final
    Repeta:        
        mov al, [s1 + esi]
        mov ah, [s2 + esi]
        add al, ah
        mov [d + esi], al
        inc esi 
        loop Repeta
    Final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
