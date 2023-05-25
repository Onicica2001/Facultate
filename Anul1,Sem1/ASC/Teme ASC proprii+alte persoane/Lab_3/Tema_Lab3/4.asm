bits 32 

global start        

extern exit            
import exit msvcrt.dll    

; a-doubleword, b,c-byte, x-qword
segment data use32 class=data
    a dd 4
    b db 2
    c db 1
    x dq 3

; (a+b)/(2-b*b+b/c)-x - interpretare cu semn

segment code use32 class=code
    start:
        ;a+b
        mov ebx, [a] ; EBX=a
        mov al, [b] ; AL=b
        cbw ; AX=b
        
        cwde ; EAX=b
        
        add ebx, eax ; EBX=a+b
        
        ;b*b
        mov al, [b] ; AL=b
        imul byte [b] ; AX=b*b
        
        ;2-b*b
        mov cx, 2 ; CX=2
        sub cx, ax ; CX=2-b*b
        
        ;b/c
        mov al, [b] ; AL=b
        cbw ; AX=b
        idiv byte [c] ; AL=b/c
        
        cbw ; AX=b/c
    
        ;2-b*b+b/c
        add cx, ax ; CX=2-b*b+b/c
        
        push ebx
        pop ax
        pop dx ; DX:AX=a+b
        
        ;(a+b)/(2-b*b+b/c)
        idiv cx ; AX=(a+b)/(2-b*b+b/c)
        
        cwde ;EAX=(a+b)/(2-b*b+b/c)
        
        cdq ; EDX:EAX=(a+b)/(2-b*b+b/c)
        
        ;(a+b)/(2-b*b+b/c)-x
        sub eax, [x]
        sbb edx, [x+4]
        
        push    dword 0    
        call    [exit]            
