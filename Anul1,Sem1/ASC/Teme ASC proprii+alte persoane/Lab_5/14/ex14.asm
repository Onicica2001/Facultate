bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;Se da un sir de octeti S. Sa se construiasca un sir D1 care sa contina toate numerele pozitive 
;si un sir D2 care sa contina toate numerele negative din S. 
segment data use32 class=data
    S db 1, 3, -2, -5, 3 , -8, 0
    l equ $-S
    D1 times 4 db 1
    D2 times 3 db -1

; our code starts here
segment code use32 class=code
    start:
        mov ECX, l 
        mov ESI, 0 
        mov EDI, 0
        mov EBX, 0 
        Repeta:
            mov al, [S+esi]
            cmp al, 0               
            JGE mai_mare_egal 
                ; if al < 0 : [D2 + ebx] = al 
            mov [D2+ebx], al
            inc ebx 
            jmp skip 
            mai_mare_egal:   ;if al >= 0 : [D1+edi] = al
                        mov [D1+edi], al 
                        inc edi 
        skip:
            inc esi
            loop Repeta 
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
