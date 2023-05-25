bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; a-byte, b-word, c-doubleword, d-qword
segment data use32 class=data
    a db 3
    b dw 2
    c dd 4
    d dq 5
    
; d-(a+b+c)-(a+a) - interpretare cu semn
segment code use32 class=code
    start:
        ;a+b
        mov al, [a] ; AL=a
        cbw ; AX=a
        add ax, [b] ; AX=a+b
        
        ;a+b+c
        cwde ; EAX=a+b
        add eax, [c] ; EAX=a+b+c
        
        ;d-(a+b+c)
        cdq ; EDX:EAX=a+b+c
        mov ebx, [d]
        mov ecx, [d+4] ; ECX:EBX=d
        sub ebx, eax
        sbb ecx, edx ; ECX:EBX=d-(a+b+x)
        
        ;a+a
        mov al, [a] ; AL=a
        add al, [a] ; AL=a+a
        
        ;d-(a+b+c)-(a+a)
        cbw ; AX=a+a
        cwde ; EAX=a+a
        cdq ; EDX:EAX=a+a
        sub ebx, eax
        sbb ecx, edx ; ECX:EBX=d-(a+b+c)-(a+a)
    
        push    dword 0     
        call    [exit]  