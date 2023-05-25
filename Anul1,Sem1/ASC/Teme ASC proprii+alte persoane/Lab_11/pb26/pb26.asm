bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fprintf, fopen, fclose, printf 
extern modificare ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    min dd 10000000000 
    a dd 0 
    cif dd 0
    format db "%d", 0
    tabela db '0123456789ABCDEF', 0
    fisier db "min.txt", 0
    mod_acces db "w", 0
    des dd -1 
    mesaj db "Introduceti numerele ", 0
    format_msg db "%s", 0 

; our code starts here
; 26. Se citeste de la tastatura un sir de numere in baza 10, cu semn. Sa se determine valoarea minima din sir si sa se afiseze in fisierul min.txt (fisierul va fi creat) valoarea minima, in baza 16.

segment code use32 class=code
    start:
    
    push dword mesaj        ; Este afisat mesajul corespunzator
    push dword format_msg 
    call [printf]
    add esp, 4*2
    
    minim: 
        push dword a        ; Se citesc numerele de la tastatura
        push dword format 
        call [scanf] 
        add esp, 4*2 
        
        mov ebx, [a]
        cmp ebx, 0          ; Conditie de oprire daca numarul citit
                            ; este 0 nu se mai citesc numere 
        
        je prelucrare
        cmp [min], ebx      ; Se compara minimul cu valoarea curenta 
        jg actualizare_min  ; Daca este mai mica valoarea curenta, 
        jmp minim           ; actualizam minimul 
        
    actualizare_min:
        mov [min], ebx      ; Actualizare minim 
        jmp minim
        
    prelucrare:
    push dword min + 3      ; Punem pe stiva offset-ul lui min 
    call modificare         ; Apelam functia din modul 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
