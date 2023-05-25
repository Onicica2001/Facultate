bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;Se da un sir A de dublucuvinte. Construiti doua siruri de octeti  
; - B1: contine ca elemente partea superioara a cuvintelor superioare din A
; - B2: contine ca elemente partea inferioara a cuvintelor inferioare din A
segment data use32 class=data
   A dd 11223344h, 22334455h, 0AABBCCDDh, 12345678h
   len_A equ ($-A)/4 
   B1 times len_A db -1
   B2 times len_A db -1
   
segment code use32 class=code
    start:
        
        mov ECX, len_A
        jecxz final   
        mov esi, A
        mov edi, B1
        mov ebx, 0 
        CLD
        repeta:
        
        lodsw  ; AX = cuvantul inferior + Esi = ESI + 2 
        mov ah, 0 ; Izolez doar octetul inferior (AL)
        mov [B2 + ebx] , al ; pun la offsetul b2 + ebx octetul corespunzator 
        inc ebx 
        
        lodsw ; AX = cuvantul superior  + Esi = ESI + 2 
        mov al, 0  ; izolez doar octetul superior (ah) 
        mov al, ah 
        stosb   ; AL -> <ES: EDI> -> B1 ; EDI = EDI + 1
        
        loop repeta
        
    final: 
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
