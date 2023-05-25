bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a, c - byte, b - word, d - dword, x - qword
    a db 4
    c db 10
    b dw 40
    d dd 200
    x dq 80

; our code starts here
; 12. (a * b + 2) / (a + 7 - c) + d + x (cu semn)
segment code use32 class=code
    start:
    mov al, [a]
    cbw              ; AX = a 
    imul word [b]    ; DX:AX = a * b 
    
    push dx 
    push ax
    pop eax         ; EAX = DX:AX = a * b 
    
    mov ecx, eax    ; ECX = EAX 
    
    mov al, 2
    cbw
    cwde            ; EAX = 2 
    
    add ecx, eax    ; ECX = ECX + EAX = (a * b + 2) 
    
    mov ebx, ecx    ; EBX = ECX = (a * b + 2)
    mov al, [a] 
    add al, 7
    sub al, [c]     ; AL = (a + 7 - c)
    cbw             ; AX = (a + 7 - c) 
    
    mov cx, ax      ; CX = AX = (a + 7 - c) 
    
    mov eax, ebx    ; EAX = EBX = (a * b + 2)
    
    push eax 
    pop ax 
    pop dx          ; DX:AX = EAX 
    
    idiv cx         ; AX = DX:AX / CX = (a * b + 2) / (a + 7 - c)
    
    cwd             ; DX:AX = (a * b + 2) / (a + 7 - c) 
    
    add ax, [d]
    adc dx, [d+2]   ; DX:AX = (a * b + 2) / (a + 7 - c) + d 
    
    push dx
    push ax 
    pop eax         ; EAX = DX:AX = (a * b + 2) / (a + 7 - c) + d 
    
    cdq             ; EDX:EAX = (a * b + 2) / (a + 7 - c) + d 
    
    add eax, [x]
    adc edx, [x+4]  ; EDX:EAX = (a * b + 2) / (a + 7 - c) + d + x
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
