bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dq 0AABBCCDDEEFFh
    n db 0
    b dw 0
    c dd 0

; Se da quadwordul A
; Sa se obtina numarul intreg N reprezentat de bitii 17-19 ai lui A
; Sa se obtina apoi in B dublucuvantul rezultat prin rotirea spre stanga a dublucuvantului superior al lui A cu N pozitii. 
;Sa se obtina octetul C astfel:
;bitii 0-2 ai lui C sunt bitii 9-11 ai lui B
;bitii 3-7 ai lui C sunt bitii 20-24 ai lui B
segment code use32 class=code
    start:
        ; Sa se obtina numarul intreg N reprezentat de bitii 17-19 ai lui A
        mov eax , dword[a]
        and eax, 00000000000011100000000000000000b
        mov cl,17
        ror eax,cl
        mov [n], eax
        
        
        ; Sa se obtina apoi in B dublucuvantul rezultat prin rotirea spre stanga a dublucuvantului superior al lui A cu N pozitii
        mov eax, dword[a]
        mov cl,[n]
        rol eax, cl
        mov [b], eax
        
        mov ebx,0
        ;bitii 0-2 ai lui C sunt bitii 9-11 ai lui B
        mov eax, [b]
        and eax,00000000000000000000111000000000b
        mov cl,9
        ror eax, cl
        or ebx,eax
        
        ;bitii 3-7 ai lui C sunt bitii 20-24 ai lui B
        mov eax,[b]
        and eax,00000001111100000000000000000000b
        mov cl, 17
        ror eax, 17
        or ebx, eax
        
        mov [c],ebx

        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program