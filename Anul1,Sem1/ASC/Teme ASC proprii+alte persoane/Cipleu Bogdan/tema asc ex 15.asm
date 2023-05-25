bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    nume_fisierului db 'ex_15_text.txt', 0
    mod_acces db 'w', 0                     ; pt scriere, fisierul nu exista dar se va crea
    descriptor_fisier dd -1
    
    text db 'Marius, ascultator fiind, a primit 50 de lei.', 0
    len equ $-text
    d times len db 0, 0
    
; 15. Se dau un nume de fisier si un text (definite in segmentul de date).
; Textul contine litere mici, litere mari, cifre si caractere speciale.
; Sa se inlocuiasca toate caracterele speciale din textul dat cu caracterul 'X'.
; Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
segment code use32 class=code
    start:
        push dword mod_acces     
        push dword nume_fisierului
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax    
        cmp eax, 0
        je final
    
        mov ecx, len
        cld
        mov esi, text 
        mov edi, d
    repeta:
        lodsb
        cmp al, ','
        je caracter_special
        
        cmp al, '.'
        je caracter_special
        
        stosb
        
    urmator:
        loop repeta
        
    jmp scrie               ; sarim peste caracter_special
        
    caracter_special:
        mov al, 'X'
        stosb
        jmp urmator         ; sarim inainte de loop, pentru ca altfel ECX nu va fi decrementat !
    
    scrie:
        push dword d        ; aici e OFFSET-ul sirului obtinut
        push dword [descriptor_fisier]
        call [fprintf]
        add esp, 4*2
        
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4*1
        
    final:
        push dword 0        ; push the parameter for exit onto the stack
        call [exit]         ; call exit to terminate the program
