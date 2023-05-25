bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining 
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in 
import printf msvcrt.dll
import scanf msvcrt.dll

                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; 16. Sa se citeasca de la tastatura doua numere a si b (in baza 10). Sa se calculeze si sa se afiseze media lor aritmetica in baza 16.
segment data use32 class=data
    a dd 0      ; in aceasta variabila vom stoca o valoare citita de la tastatura
    b dd 0      ; in aceasta variabila vom stoca a doua valoare citita de la tastatura
    c dw 2
    mesaj_1 db 'Introduceti primul numar: ',0
    mesaj_2 db 'Introduceti al doilea numar: ',0
    mesaj_final db 'Media aritmetica in hexazecimal este: %x',0
    format_1 db '%d',0
    
; our code starts here
segment code use32 class=code
    start:
        push dword mesaj_1
        call [printf]
        add esp, 4*1
        push dword a
        push dword format_1
        call [scanf]
        add esp, 4*2
        
        push dword mesaj_2
        call [printf]
        add esp, 4*1
        push dword b
        push dword format_1 
        call [scanf]
        add esp, 4*2
        
        mov eax,0
        mov edx,0
        mov eax,[a]
        add eax,[b]
        mov bx,0
        mov bx, [c]
        div bx 
        
        push eax
        push dword mesaj_final
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
