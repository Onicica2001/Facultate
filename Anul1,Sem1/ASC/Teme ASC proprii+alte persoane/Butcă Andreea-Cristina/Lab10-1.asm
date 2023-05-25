bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll  ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll   ; similar pentru scanf
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; APELURI DE FUNCTII SISTEM
; 23. Sa se citeasca de la tastatura un numar hexazecimal format din 2 cifre. Sa se afiseze pe ecran acest numar in baza 10, interpretat atat ca numar fara semn cat si ca numar cu semn (pe 8 biti).
segment data use32 class=data
    n dd 0
    message db "n=", 0
    format db "%x", 0       ; definim formatul, %x -> un numar in baza 16
    format_rez1 db "Intepretarea fara semn: %u ; ", 0
    format_rez2 db "Intepretarea cu semn: %d", 0
    zece dd 10

    ;n=13
; our code starts here
segment code use32 class=code
    start:
        ; vom apela printf(message) => se va afisa "n="
        ; punem parametrii pe stiva
        push dword message  ; punem pe stiva adresa string-ului, nu valoarea
        call [printf]       ; apelam functia printf pentru afisare
        add esp, 4*1        ; eliberam parametrii de pe stiva 
                            ; 4 = dimensiunea unui dword 
                            ; 1 = nr de parametri
                            
        ; vom apela scanf(format, n) => se va citi un numar in variabila n
        ; punem parametrii pe stiva de la dreapta la stanga
        push dword n       ; adresa lui n
        push dword format
        call [scanf]       ; apelam functia scanf pentru citire
        add esp, 4*2       ; eliberam parametrii de pe stiva
                           ; 4 = dimensiunea unui dword 
                           ; 2 = nr de parametri
        
        ;printf("%u", n), afisam valoarea lui n in baza 10 interpretat fara semn     
        push dword [n]       
        push dword format_rez1
        call [printf]       
        add esp, 4*2 
        
        ;printf("%d", n), afisam valoarea lui n in baza 10 interpretat cu semn
        push dword [n]       
        push dword format_rez2
        call [printf]       
        add esp, 4*2      
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
