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
; 12. (a * b + 2) / (a + 7 - c) + d + x (fara semn)
segment code use32 class=code
    start:
    mov al, [a]
    mov ah, 0       ; AX = a = 4
    mul word [b]    ; DX:AX = a * b = 160
    
    mov bl, 2
    mov bh, 0       ; BX = 2 
    mov cx, 0       ; CX:BX = 2
    
    add ax, bx
    adc dx, cx      ; DX:AX = (a * b + 2)
    
    mov cl, [a]
    add cl, 7
    sub cl, [c] 
    mov ch, 0       ; CX = (a + 7 - c) 
    
    div cx          ; AX = DX:AX / CL, DX = DX:AX % CL, AX = (a * b + 2) / (a + 7 - c) 
    
    mov dx, 0
    add ax, [d]
    adc dx, [d+2]   ; DX:AX = (a * b + 2) / (a + 7 - c) + d
    
    push dx
    push ax
    pop eax         ; EAX = DX:AX = (a * b + 2) / (a + 7 - c) + d
    
    mov edx, 0
    add eax, [x]
    adc edx, [x+4]  ; EDX:EAX = (a * b + 2) / (a + 7 - c) + d + x
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
