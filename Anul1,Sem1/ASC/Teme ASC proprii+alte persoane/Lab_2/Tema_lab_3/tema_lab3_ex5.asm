bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    b db 0
    c db 1
    e dw 4
    f dw 5
    g dw 7

; our code starts here
segment code use32 class=code
    start:
        ;[(e+f-g)+(b+c)*3]/5
        mov ax, [e]
        add ax, [f]
        sub ax, [g]
        mov bx, ax ; bx = e+f-g
        mov al, [b]
        add al, [c]
        mov dl, 3
        mul dl
        add ax, bx ; ax = (e+f-g)+(b+c)*3
        mov dl, 5
        div  dl
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
