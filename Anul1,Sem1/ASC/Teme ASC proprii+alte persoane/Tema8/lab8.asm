bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0 
    format_a db "Introduceti octetul ", 0
    format_b db "Introduceti cuvantul ", 0
    citire db "%d", 0
    format_1 db "%s", 0
    mesaj1 db "DA", 0
    mesaj2 db "NU", 0
    format db "%s", 0
    
; 19. Sa se citeasca de la tastatura un octet si un cuvant. Sa se afiseze pe ecran daca bitii octetului citit se regasesc consecutiv printre bitii cuvantului. Exemplu:
; a = 10 = 0000 1010b
; b = 256 = 0000 0001 0000 0000b
; Pe ecran se va afisa NU.
; a = 0Ah = 0000 1010b
; b = 6151h = 0110 0001 0101 0001b
; Pe ecran se va afisa DA (bitii se regasesc pe pozitiile 5-12).

segment code use32 class=code
    start:
        ; afisam mesajul pentru introducerea octetului
        push dword format_a 
        push dword format_1
        call [printf]
        add esp, 4*2
        
        ; citim octetul de la tastatura
        push dword a 
        push dword citire 
        call [scanf] 
        add esp, 4*2
        
        ; afisam mesajul pentru citirea cuvantului
        push dword format_b 
        push dword format_1
        call [printf]
        add esp, 4*2
        
        ; citim cuvantul de la tastatura 
        push dword b 
        push dword citire 
        call [scanf] 
        add esp, 4*2
        
        ; datele citite se pun in registrii pentru a fi prelucrate
        mov al, [a]
        mov bx, [b] 
        mov ecx, 16 
        jecxz final 
        
        repeta:
        ror bx, 1       ; rotim cuvantul si apoi comparam cu AL si daca 
        cmp al, bl      ; scaderea fictiva este 0 atunci bitii lui a se gasesc 
        je adevarat     ; consecutiv printre cei ai lui b 
        loop repeta 

    fals:
        push dword mesaj2   ; se afiseaza mesajul NU pentru ca nu s-au gasit bitii 
        push dword format 
        call [printf]
        add esp, 4*2
        jmp final 
    
    adevarat:
        push dword mesaj1   ; se sare la eticheta daca s-au gasit bitii 
        push dword format 
        call [printf]
        add esp, 4*2
    
    
    final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
