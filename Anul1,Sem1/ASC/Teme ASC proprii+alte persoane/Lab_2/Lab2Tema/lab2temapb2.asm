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
    a db 2
    d dw 10
    e dw 5
    c dw 300
    aux dw 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,2
        mul byte[a]
        mov bx,[d]
        sub bx,ax
        mov ax,[e]
        mul bx
        mov word[aux+0],ax
        mov word[aux+2],dx
        dec word[aux]
        mov cl,[c]
        mov ch,0
        sub cx,word[aux]
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
