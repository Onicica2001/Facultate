bits 32
global start        
extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    a db 10h
    b dw 1010h
    c dd 10101010h
    d dq 10101010101010h
    aux1 dd 0
    aux2 dd 0
segment code use32 class=code
    start:
        ;(b-a+c-d)-(d+c-a-b)
        
        ;calculez b - a
        mov al, [a]
        cbw             ;AX = a
        mov bx, [b]
        sub bx, ax      ;BX = b - a
        
        ;calculez b - a + c
        mov ax, bx
        cwd             ;DX:AX = b - a
        mov bx, [c]
        mov cx, [c+2]   ;CX:BX = c
        add dx, cx
        adc ax, bx      ;DX:AX = b - a + c
        
        ;calculez b - a + c - d
        push dx
        push ax
        pop eax
        cdq             ;EDX:EAX = b - a + c
        mov ebx, [d]
        mov ecx, [d+4]  ;ECX:EBX = d
        sub edx, ecx
        sbb eax, ebx    ;EDX:EAX = b - a + c - d
        mov [aux1], edx
        mov [aux2], eax ;aux1:aux2 = b - a + c - d
        
        ;calculez d + c
        mov eax, [c]
        cdq             ;EDX:EAX = c
        add edx, [d+4]
        adc eax, [d]    ;EDX:EAX = d + c
        
        ;calculez d + c - a
        mov ecx, edx
        mov ebx, eax    ;ECX:EBX = d + c
        mov al, [a]
        cbw
        cwde            ;EAX = a
        cdq             ;EDX:EAX = a
        sub ecx, edx
        sbb ebx, eax    ;ECX:EBX = d + c - a
        
        ;calculez d + c - a - b
        mov ax, [b]
        cwde            ;EAX = b
        cdq             ;EDX:EAX = b
        sub ecx, edx
        sbb ebx, eax    ;ECX:EBX = d + c - a - b
        
        ;calculez (b - a + c - d) - (d + c - a - b)
        mov edx, [aux1]
        mov eax, [aux2] ;EDX:EAX = b - a + c - d
        sub edx, ecx
        sbb eax, ebx    ;EDX:EAX = (b - a + c - d) - (d + c - a - b)
        
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
