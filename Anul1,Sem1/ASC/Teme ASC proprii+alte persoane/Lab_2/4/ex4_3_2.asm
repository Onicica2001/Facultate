bits 32 

global start        

extern exit          
import exit msvcrt.dll

segment data use32 class=data
    ;a,b,c,d-byte, e,f,g,h-word
    a db 4
    b db 3
    c db 2
    d db 1
    e dw 1
    f dw 2
    g dw 3
    h dw 4

segment code use32 class=code
    start:
        ;(a-c)*3+b*b
        
        mov eax,0
        mov al,[a]
        sub al,[c]
        mul byte [b]
        
        mov ebx,0
        mov ebx,eax
        mov eax,0
        
        mov eax,0
        mov al,[b]
        mul byte [b]
        add eax,ebx
    
        push    dword 0    
        call    [exit]     
