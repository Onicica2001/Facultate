bits 32 

global start        

extern exit              
import exit msvcrt.dll   

segment data use32 class=data
    ;a,b,c - byte, d - word
    a db 2
    b db 3
    c db 4
    d dw 2
    rez resw 1

segment code use32 class=code
    start:
        ;–a*a + 2*(b-1) – d
        mov eax,0
        sub al,[a]
        mul byte [a]
        
        mov ebx,0
        mov ebx,eax
        
        mov eax,0
        mov al,[b]
        sub al,1
        mov dl,2
        mul dl
        sub eax,[d]
        
        add ebx,eax
        mov [rez],ebx
    
        push    dword 0
        call    [exit] 