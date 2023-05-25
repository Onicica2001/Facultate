bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;a,b,c,d-byte, e,f,g,h-word
    a db 4
    b db 2
    c db 3
    d db 1
    e dw 11
    f dw 12

; our code starts here
segment code use32 class=code
    start:
        ;[b*c-(e+f)]/(a+d)
        mov eax, 0
        mov al, [b]
        mov ah, [c]
        mul ah
        
        mov ebx, 0
        mov bx, [e]
        add bx, [f]
            
            
        
        sub ax, bx

        mov ecx, 0
        mov cl, [a]
        add cl, [d]
        
        push dx
        push ax
        pop eax
        div cl 
        
        
         
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
