; Se dau cuvintele A si B. Se cere dublucuvantul C:
; bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
; bitii 4-10 ai lui C sunt invers fata de bitii 0-6 ai lui B
; bitii 11-18 ai lui C sunt 1
; bitii 19-31 ai lui C coincid cu bitii 3-15 ai lui B


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
    a dw 0110001110101100b
    b dw 1010010101010110b
    c dd 0   ; => 2,774,006,426

; our code starts here
segment code use32 class=code
    start:
        mov ebx, 0  ; => In regsitrul EBX vom calcula rezultatul
        mov eax, 0
        mov ax, [b]  ; => izolam bitii 5-8 ai lui b
        and ax, 0000000111100000b
        ror ax, 5   ;  => rotim 5 pozitii spre dreapta
        or ebx, eax  ; => punem bitii in rezultat pe pozitiile 0-3
        
        mov eax, 0
        mov ax, [b]  ; => vom izolva bitii 0-6 ai lui b
        not ax  ; inversam valoarea lui b
        and ax, 0000000001111111b
        rol ax, 4  ; rotim spre stanga 4 pozitii
        or ebx, eax ; punem in rezultat
        
        or ebx, 00000000000001111111100000000000b ; punem 1 pe bitii 11-18
        
        mov eax, 0
        mov ax, [b]  ;izolam bitii 3-15 ai lui b
        and ax, 1111111111111000b
        rol eax, 16 ; rotim spre stanga 16 pozitii
        or ebx, eax ; punem in rezultat
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
