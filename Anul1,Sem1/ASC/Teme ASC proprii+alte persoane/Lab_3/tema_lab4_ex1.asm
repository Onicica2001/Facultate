bits 32 ; assembling for the 32 bits architecture
global start        
extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    
        a db 10
        b dw 30
        c dd 100
        d dq 1000
; our code starts here
segment code use32 class=code
    start:
        ;d-b+a-(b+c) - interpretare fara semn
        
        ;convertesc b din word -> doubleword
        mov ax, [b]
        mov dx, 0       ;DX:AX = b
        
        ;b + c
        mov bx, [c]
        mov cx, [c+2]   ;CX:BX = c
        add ax, bx
        adc dx, cx      ;DX:AX = b + c
        
        ;convertesc a din byte -> word
        mov bl, [a]
        mov bh, 0
        
        ;a - b
        sub bx, [b]     ;BX = - b + a
        
        ;convertesc -b+a din word -> doubleword
        mov cx, 0       ;CX:BX = - b + a
        
        ; - b + a - (b + c)
        sub cx, dx
        sbb bx, ax      ;CX:BX = - b + a - (b + c)

        ;convertesc - b + a - (b + c) din double -> quad
        push cx
        push bx
        pop eax
        mov edx, 0      ;EDX:EAX = - b + a - (b + c)
        
        ; d - b + a - (b + c)
        mov ebx, [d]
        mov ecx, [d+4]
        sub ecx, edx
        sbb ebx, eax    ;ECX:EBX = - b + a - (b + c)
        ; exit(0)
        push    dword 0      
        call    [exit]       
