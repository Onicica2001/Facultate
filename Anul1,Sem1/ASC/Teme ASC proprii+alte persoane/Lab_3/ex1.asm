bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
segment data use32 class=data
    ; ...
    a db 15
    b dw 40
    c dd 50
    d dq 25

; (a+d+d)-c+(b+b)  => 95
; our code starts here
segment code use32 class=code
    start:

        mov eax, 0  ; Pentru ca a sa fie convertit la dword fara semn
        mov edx, 0
        mov al, [a]
        
        add eax, dword [d]  
        adc edx, dword [d + 4] ;  => EDX:EAX = a+d
        
        add eax, dword [d]  
        adc edx, dword [d + 4] ;  => EDX:EAX = a+d+d
        
        ; calculam (a+d+d) - c = EDX:EAX - c
        sub eax, dword [c]
        sbb edx, 0  ; EDX:EAX = (a+d+d) - c
        
        ; calculam b+b
        mov ebx, 0
        mov bx, [b]
        add bx, [b] ; => BX = b+b
        
        ; calculam (a+d+d)-c+(b+b) = EDX:EAX + BX
        add eax, ebx
        adc edx, 0  ; Rezultat in EDX:EAX

        
         
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
