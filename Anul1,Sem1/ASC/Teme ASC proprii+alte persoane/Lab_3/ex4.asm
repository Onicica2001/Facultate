bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,c-byte; b-word; d-doubleword; x-qword CU semn
segment data use32 class=data
    ; ...
    a db 4
    c db -2
    b dw 1
    d dd -10
    x dq 25

; d-(7-a*b+c)/a-6+x/2         = 19
segment code use32 class=code
    start:
        ; ...
        ; calculam a*b
        mov ax, [b] ; AX = b
        imul byte [a]  ; AX = a*b
        
        ;calculam 7 - a*b = 7 - AX = BX - AX  (unde BX = 7)
        mov bx, 7
        sub bx, ax ; ==> BX = 7-a*b
        
        ;calculam 7-a*b+c = BX + c
        mov al, [c]
        cbw ; AM convertit cu semn la word
        add ax, bx ; => AX = 7-a*b+c
        idiv byte [a]  ;  => AL = (7-a*b+c)/a
        
        ; calculam d - (7-a*b+c)/a = d - AL
        ; convertim AL la dword
        mov bl, al
        mov al, bl
        cbw
        cwde
        mov ecx, eax
        mov ebx, [d]
        sub ebx, eax ; =>> EBX = d-(7-a*b+c)/a
        
        sub ebx, 6 ;  => EBX = d-(7-a*b+c)/a-6
        
        ;calculam x/2
        mov eax, dword [x]
        mov edx, dword [x+4] ; EDX:EAX = x
        mov ecx, 2
        idiv ecx  ;  EAX = x/2
       
        ;calculam d-(7-a*b+c)/a-6+x/2
        add eax, ebx  ; => rezultatul in EAX
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
