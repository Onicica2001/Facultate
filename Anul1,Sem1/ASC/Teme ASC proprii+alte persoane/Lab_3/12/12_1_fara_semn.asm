bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a - byte, b - word, c - dword, d - qword
    a db 12
    b dw 10
    c dd 10
    d dq 60

; our code starts here
; 12. ( a + b + d ) - ( a - c + d ) + ( b - c ) (fara semn)
segment code use32 class=code
    start:
        ; ...
    mov al, [a]     ; AL = a = 12
    mov ah, 0       ; AX = a = 12
    add ax, [b]     ; AX = AX + b = 12 + 10 = 22
    mov dx, 0       ; DX:AX = ( a + b ) = 22 
    
    push dx         
    push ax 
    pop eax         ; EAX = ( a + b ) = 22
    mov edx, 0      ; EDX:EAX = 22
    
    add eax, [d]    
    adc edx, [d+4]  ; EDX:EAX = ( a + b + d ) = 82 
    mov ebx, eax
    mov ecx, edx    ; ECX:EBX = ( a + b + d ) = 82 
    
    mov al, [a] 
    mov ah, 0       ; AX = a = 12 
    mov dx, 0       ; DX:AX = a = 12
    
    push dx
    push ax 
    pop eax         ; EAX = 12 = a
    sub eax, [c]    ; EAX - c = 12 - 10 = 2
    
    mov edx, 0      ; EDX:EAX = a - c = 2 
    add eax, [d]
    adc edx, [d+4]  ; EDX:EAX = a - c + d = 62
    sub ebx, eax 
    sbb ecx, edx    ; ECX:EBX = ( a + b + d ) - ( a - c + d ) = 20 
    
    mov ax, [b]     ; AX = b = 10
    mov dx, 0       ; DX:AX = b = 10
    sub ax, [c]
    sbb dx, [c+2]   ; DX:AX = b - c = 0
    
    push dx
    push ax
    pop eax         ; EAX = b - c
    mov edx, 0      ; EDX:EAX = b - c
    add eax, ebx 
    adc edx, ecx    ; EDX:EAX = ( a + b + d ) - ( a - c + d ) + ( b - c ) = 20 + 0 = 20
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
