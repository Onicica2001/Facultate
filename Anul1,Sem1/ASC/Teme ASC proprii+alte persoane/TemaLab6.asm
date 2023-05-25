bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 4142h, 4345h, 4647h
    len equ ($-a)/2
    b1 times len db 0
    b2 times len db 0

; 10. Se da un sir A de cuvinte. Construiti doua siruri de octeti  
; - B1: contine ca elemente partea superioara a cuvintelor din A
; - B2: contine ca elemente partea inferioara a cuvintelor din A
segment code use32 class=code
    start:
        mov ecx, len
        jecxz final_1
        
        ; directia de parcurgere
        cld                        ; DF = 0
        
        ; incarcam registrii index 
        mov esi, a                 
        mov edi, 0                 
        mov ebx, 0                 
        
    repeta1:
        lodsb                      ;AL = octetul inferior
        lodsb                      ;AL = octetul superior
        
        ; AL
        ; 41 
        mov [b1+edi], al
        inc edi
        
    loop repeta1
    
    final_1:
        
        mov ecx, len
        jecxz final
        
        mov esi, a
        
    repeta2:
        lodsb                      ;AL = octetul inferior
    
        ; AL
        ; 42
        mov [b2+ebx], al
        inc ebx
        
        lodsb
        
    loop repeta2
    
    final:    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
