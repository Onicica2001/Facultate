bits 32 
global start        
extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    ;x-(a+b+c*d)/(9-a) - interpretare fara semn
    a db 1h
    b dd 1010h
    c db 10h
    d db 10h
    x dq 9999999999999999h
segment code use32 class=code
    start:
        ;calculez c * d
        mov al, [c]
        mul byte [d]         ;AX = c * d
        mov dx, 0       ;DX:AX = c * d
        
        ;calculez a + b
        mov bl, [a]
        mov bh, 0       ;BX = a
        mov cx, 0       ;CX:BX = a
        add bx, [b]
        adc cx, [b+2]   ;CX:BX = a + b
        
        ;calculez a + b + c * d
        add dx, cx
        adc ax, bx      ;DX:AX = a + b + c * d
        
        ;calculez 9 - a
        mov bl, 9
        sub bl, [a]     ;BL = 9 - a
        mov bh, 0       ;BX = 9 - a
        
        ;calculez (a + b + c * d) / (9 - a)
        div bx          ;AX = (a + b + c * d) / (9 - a)
        
        ;calculez x - (a + b + c * d) / (9 - a)
        mov dx, 0
        push dx
        push ax
        pop eax         ;EAX = (a + b + c * d) / (9 - a)
        mov edx, 0      ;EDX:EAX = (a + b + c * d) / (9 - a)
        mov ebx, [x]
        mov ecx, [x+4]  ;ECX:EBX = x
        sub ecx, edx
        sbb ebx, eax    ;ECX:EBX = x - (a + b + c * d) / (9 - a)
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
