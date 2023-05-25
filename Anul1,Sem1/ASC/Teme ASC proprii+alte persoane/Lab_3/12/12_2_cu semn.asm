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
    a db 10
    b dw 15
    c dd 20
    d dq 47

; our code starts here
; 12. (a - b - c) + (d - b - c) - (a - d) (cu semn)
segment code use32 class=code
    start:
    
    mov al, [a]
    cbw
    sub ax, [b]     ; AX = a - b 
    cwd
    sub ax, [c]
    sbb dx, [c+2]   ; DX:AX = (a - b - c) 
    
    push dx
    push ax 
    pop eax         ; EAX = (a - b - c) 
    cdq             ; EDX:EAX = (a - b - c)  
    
    mov ebx, eax 
    mov ecx, edx    ; ECX:EBX = EDX:EAX = (a - b - c) 
    
    mov ax, [b] 
    cwd             ; DX:AX = b 
    add ax, [c]
    adc dx, [c+2]   ; DX:AX = b + c 
    
    push dx
    push ax
    pop eax 
    cdq             ; EDX:EAX = b + c 
    
    sub eax, [d]
    sbb edx, [d+4]  ; EDX:EAX = (b + c - d)
    
    sub ebx, eax 
    sbb ecx, edx    ; ECX:EBX = (a - b - c) - (b + c - d) = (a - b - c) + ( d - b - c ) 
    
    mov al, [a]
    cbw
    cwde            ; EAX = a 
    cdq             ; EDX:EAX = a 
    sub eax, [d]
    sbb edx, [d+4]  ; EDX:EAX = (a - d)
    
    sub ebx, eax
    sbb ecx, edx    ; ECX:EBX = (a - b - c) + (d - b - c) - (a - d)     
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
