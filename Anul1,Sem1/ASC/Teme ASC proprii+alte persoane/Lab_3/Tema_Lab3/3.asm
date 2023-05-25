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

; (a+b)/(2-b*b+b/c)-x - interpretare fara semn

segment code use32 class=code
    start:
        ;a+b
        mov eax, [a] ; EAX=a
        mov bl, [b] ; BL=b
        mov bh, 0 ; BX=b
        
        mov cx, 0 ; CX:BX=b
        
        push cx
        push bx
        pop ebx ; EBX=b
        
        add ebx, eax ; EBX=a+b
        
        ;b*b
        mov al, [b] ; AL=b
        mul byte [b] ; AX=b*b
        
        ;2-b*b
        mov cx, 2 ; CX=2
        sub cx, ax ; CX=2-b*b
        
        ;b/c
        mov al, [b] ; AL=b
        mov ah, 0 ; AX=b
        div byte [c] ; AL=b/c
        
        mov ah, 0 ; AX=b/c
    
        ;2-b*b+b/c
        add cx, ax ; CX=2-b*b+b/c
        
        push ebx
        pop ax
        pop dx ; DX:AX=a+b
        
        ;(a+b)/(2-b*b+b/c)
        div cx ; AX=(a+b)/(2-b*b+b/c)
        
        mov dx, 0 ; DX:AX=(a+b)/(2-b*b+b/c)
        push dx
        push ax
        pop eax ; EAX=(a+b)/(2-b*b+b/c)
        
        mov edx, 0 ; EDX:EAX=(a+b)/(2-b*b+b/c)
        
        ;(a+b)/(2-b*b+b/c)-x
        sub eax, [x]
        sbb edx, [x+4]
        
        push    dword 0    
        call    [exit]     
