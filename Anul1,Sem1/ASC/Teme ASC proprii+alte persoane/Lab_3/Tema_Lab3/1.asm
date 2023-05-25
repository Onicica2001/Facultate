bits 32

global start        

extern exit               
import exit msvcrt.dll 

; a-byte, b-word, c-doubleword, d-qword
segment data use32 class=data
    a db 3
    b dw 6
    c dd 7
    d dq 10

; (d-c)+(b-a)-(b+b+b) - interpretare fara semn
segment code use32 class=code
    start:
        ;d-c
        mov eax, [d]
        mov edx, [d+4] ; EDX:EAX=d
        mov ebx, [c] ; ECX=c
        mov ecx, 0 ; ECX:EBX=c
        sub eax, ebx
        sbb edx, ecx ; EDX:EAX=d-c
        
        ;b-a
        mov bx, [b] ; BX=b
        mov cl, [a]
        mov ch, 0 ; CX=a
        sub bx, cx ; BX=b-a
        
        mov cx, 0 ; CX:BX=b-a
        push cx
        push bx
        pop ebx ; EBX=b-a
        
        mov ecx, 0 ; ECX:EBX=b-a
        
        ;(d-c)+(b-a)
        add eax, ebx
        adc edx, ecx ; EDX:EAX=(d-c)+(b-a)
        
        ;b+b
        mov cx, [b] ; CX=b
        add cx, [b] ; CX=b+b
        
        ;b+b+b
        add cx, [b] ; CX=b+b+b
        
        mov bx, 0 ; BX:CX=b+b+b
        push bx
        push cx
        pop ebx ; EBX=b+b+b
        
        mov ecx, 0 ; ECX:EBX=b+b+b
        
        ; (d-c)+(b-a)-(b+b+b)
        sub eax, ebx
        sbb edx, ecx ; EDX:EAX=(d-c)+(b-a)-(b+b+b)
    
        push    dword 0      
        call    [exit]       
