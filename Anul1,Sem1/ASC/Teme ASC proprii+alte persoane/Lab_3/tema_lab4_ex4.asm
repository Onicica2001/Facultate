bits 32 
global start        
extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    ;x-(a+b+c*d)/(9-a) - interpretare cu semn
    a db 1h
    b dd 1010h
    c db 10h
    d db 10h
    x dq 999999999999h
    aux dw 0
segment code use32 class=code
    start:
        ;calculez c * d
        mov al, [c]
        imul byte [d]   ;AX = c * d
        cwd
        mov cx, dx
        mov bx, ax      ;CX:BX = c * d      
        
        ;calculez a + b
        mov al, [a]
        cbw             ;AX = a
        cwd             ;DX:AX = a
        add ax, [b]
        adc dx, [b+2]   ;DX:AX = a + b
        
        ;calculez a + b + c * d
        add cx, dx
        adc bx, ax      ;CX:BX = a + b + c * d
        
        ;calculez 9 - a
        mov al, 9
        sub al, [a]     ;AL = 9 - a
        cbw             ;AX = 9 - a
        mov [aux], ax   ;aux = 9 - a
        
        ;calculez (a + b + c * d) / (9 - a)
        mov ax, bx
        mov dx, cx      ;DX:AX = a + b + c * d        
        idiv word [aux]    ;AX = (a + b + c * d) / (9 - a)
        
        ;calculez x - (a + b + c * d) / (9 - a)
        cwde            ;EAX = (a + b + c * d) / (9 - a)
        cdq             ;EDX:EAX = (a + b + c * d) / (9 - a)
        mov ebx, [x]
        mov ecx, [x+4]  ;ECX:EBX = x
        sub ecx, edx
        sbb ebx, eax    ;ECX:EBX = x - (a + b + c * d) / (9 - a)
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
