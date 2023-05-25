bits 32 

global start        

extern exit           
import exit msvcrt.dll

segment data use32 class=data
    
    a dw 2
    b dw 4
    c dw 2
    d dw 1
    r resw 1

segment code use32 class=code
    start:
        ;(b+b)-c-(a+d)
        
        mov eax,0
        mov ax,[b]
        add ax,[b]
        
        mov ebx,0
        mov bx,[a]
        sub bx,[d]
        
        sub ax,[c]
        sub eax,ebx
        
        mov [r],eax
    
        push    dword 0
        call    [exit] 
