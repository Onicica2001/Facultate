bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; ;a - byte, b - word, c - double word, d - qword 
segment data use32 class=data
    ; ...
          a db 5
          b dw 112
          c dd 100

; 14. c-b-(a+a)-b Interpretare cu semn
segment code use32 class=code
    start:
        ; c-b  unde c- 32 biti si b-16 biti
        mov cx, word[c]
        mov bx, word [c+2] ;  BX:CX=c
        mov ax, [b]        ;  AX=b
        cwd                ; conversia cu semn de la AX la DX:AX---> DX:AX=b
        sub cx,ax     
        sbb bx,dx          ; BX:CX= c-b (32 de biti)
        
        ;a+a
        mov al,[a]         ; AL=a
        add al,[a]         ; AL= a+a     
        cbw                ; conversia fara semn de la AL la AX        
        cwd                ; conversia fara semn de la AX la DX:AX----->DX:AX=a+a
        
        ;c-b-(a+a)
        sub cx,ax
        sbb bx,dx          ; BX:CX=c-b-(a+a)
     
        ;c-b-(a+a)-b
        mov ax,[b]         ; AX=b
        cwd                ; conversia fara semn de la AX la DX:AX-----> DX:AX=b
        sub cx,ax
        sbb bx,dx          ; BX:CX= c-b-(a+a)-b
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
