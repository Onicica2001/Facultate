bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b,c-byte; d-doubleword; e-qword
segment data use32 class=data
    a db 3
    b db 4
    c db 2 
    d dd 20
    e dq 50

; 2. 2/(a+b*c-9)+e-d in interpretarea fara semn
segment code use32 class=code
    start:
        
        ;calculez (b*c)
        
        mov al , [b]
        mul byte [c]
        ;ax = ax * c = (b*c)
        
        mov bl , [a]
        
        ;convertesc interpretarea fara semn byte-ul bl la bx 
        mov bh , 0 ; bx = a 
        
        ;calculez (a+b*c)
        add bx , ax ; bx = bx + ax = (a+b*c)
        
        ;calculez (a+b*c-9)
        sub bx , 9 ; bx = bx - 9 = (a+b*c-9)
        
        mov ax , 2 ; ax = 2 
        
        ;convertesc in interpretarea fara semn word-ul ax la dx:ax pentru a putea efectua impartirea cu bx 
        mov dx , 0 ; dx:ax = 2 
        
        ;calculez 2/(a+b*c-9)
        div bx ; dx:ax / bx = ax si dx:ax % bx = dx (catul impartirii va fi retinut in ax , respectiv restul in dx)
        ;ax = 2/(a+b*c-9)
        
        ;convertesc in interpretarea fara semn word-ul ax la dx:ax
        mov dx , 0 ; dx:ax = 2/(a+b*c-9)
        
        push dx 
        push ax 
        pop eax 
        ;eax = dx:ax = 2/(a+b*c-9)
        
        ;convertesc in interpretarea fara semn dword-ul eax la edx:eax
        mov edx , 0 ; edx:eax = 2/(a+b*c-9)
        
        mov ebx , dword [e+0]
        mov ecx , dword [e+4]
        ;ecx:ebx = e 
        
        ;calculez 2/(a+b*c-9)+e
        
        add eax , ebx 
        adc edx , ecx 
        ; edx:eax = 2/(a+b*c-9)+e
        
        mov ebx , [d]
        
        ;convertesc in interpretarea fara semn dword-ul ebx la ecx:ebx
        mov ecx , 0 ; ecx:ebx = d 
        
        ;calculez 2/(a+b*c-9)+e-d
        sub eax , ebx 
        sbb edx , ecx 
        ; edx:eax = 2/(a+b*c-9)+e-d
 
 
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
