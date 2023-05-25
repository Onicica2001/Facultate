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
    s dw -22, 145, -48, 127 
    len_s equ ($-s)/2
    d times len_s db -1 

; 6. Se da un sir de cuvinte s. Sa se construiasca sirul de octeti d, astfel incat d sa contina pentru fiecare pozitie din s:
; - numarul de biti de 0, daca numarul este negativ
; - numarul de biti de 1, daca numarul este pozitiv

segment code use32 class=code
    start:
        mov ecx, len_s + 1
        jecxz final
        
        cld                             ; setam directia de parcurgere
        mov esi, s 
        mov edi, d - 1
        
        extrage:  
            mov al, dl                  ; punem in AL numarul de biti 0 sau 1 in functie de ramura urmata
            stosb                       ; se pune in d valoarea din AL 
            dec ecx 
            jecxz final
            mov dl, 0
            mov ebx, 16                 ; numarul de pasi pentru parcurgerea tuturor bitilor din fiecare cuvant
            lodsb 
            lodsb 
            cmp al, 0                   ; AL are valoarea octetului superior si se stabileste daca este pozitiv sau negativ
            jl numar
            jnl numar_poz
            
        loop extrage
 
    numar:
        sub esi, 2                      ; se incarca numarul negativ in AX si se elibereaza CF 
        lodsw 
        clc 
        jmp prelucrare
        
    prelucrare:
        cmp ebx, 0
        je extrage
        rcr ax, 1                       ; rotim cuvantul din AX 
        dec ebx 
            jnc numarare_biti_de_0      ; verificam daca valoarea din CF este 0
        jmp prelucrare
        
    numarare_biti_de_0:
        inc dl                          ; incrementam numarul de biti de 0 
        jmp prelucrare
    
    numar_poz:
        sub esi, 2                      ; se incarca numarul pozitiv in AX si se elibereaza CF 
        lodsw 
        clc 
        jmp prelucrare_poz 
        
    prelucrare_poz:
        cmp ebx, 0
        je extrage
        rcr ax, 1
        dec ebx 
            jc numarare_biti_de_1       ; verificam daca valoarea din CF este 1
        jmp prelucrare_poz
       
    numarare_biti_de_1:
        inc dl                          ; incrementam numarul de biti de 1
        jmp prelucrare_poz
    
        
    final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
