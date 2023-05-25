bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fprintf, fopen, fclose, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a resb 100
    b dd 32
    citire_a db "%s", 0
    fisier db "numere.txt", 0
    acces db "w", 0 
    descriptor dd -1 
    mesaj db "Introduceti numerele care sa se scrie in fisier ", 0

; 12. Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura numere si sa se scrie valorile citite in fisier pana cand se citeste de la tastatura valoarea 0.
segment code use32 class=code
    start:
        ; ...
        push dword mesaj        ; afisam mesajul pentru utilizator 
        push dword citire_a 
        call [printf] 
        add esp, 4*2
        
        push dword acces        ; deschidem fisierul 
        push dword fisier 
        call [fopen]
        add esp, 4*2 
        
        mov [descriptor], eax 
        cmp eax, 0
        je final 
        
        repeta:
        
        push dword a        ; se citeste de la tastatura numarul curent
        push dword citire_a
        call [scanf] 
        add esp, 4*2
        
        mov ebx, [a]        ; se compara daca numarul este 0 
        cmp bl, 48
        je final 
        
        push dword a            ; se scriu in fisier numerele citite
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2 
        
        push dword b            ; se adauga spatiu dupa fiecare numar citit 
        push dword [descriptor] 
        call [fprintf] 
        add esp, 4*2
        
        jmp repeta
        
    final:
        
        push dword [descriptor]     ; se inchide fisierul dupa ce se citeste 0 
        call [fclose] 
        add esp, 4 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
