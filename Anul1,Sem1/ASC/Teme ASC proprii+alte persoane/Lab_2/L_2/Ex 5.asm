bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
; a,b,c,d-byte
segment data use32 class=data
    ; ...
    a db 14
    b db 5
    c db 3
    d db 10

; our code starts here
; [(a-d)+b]*2/c
segment code use32 class=code
    start:
        ; ...
        
        ; Calculam a - d
        mov al, [a]
        sub al, [d]
        
        ; Calculam (a - d) + b = AL + b (= BL)
        add al, [b]
        mov bl, al
        
        
        ; Calculam 2 / c
        mov ax, 2
        div byte [c] ; AL = AX / c = 2 / c
        
        ; Calculam [(a - d) + b] * 2 / c = BL * AL
        mul bl ; Avem raspunsul in AX
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
