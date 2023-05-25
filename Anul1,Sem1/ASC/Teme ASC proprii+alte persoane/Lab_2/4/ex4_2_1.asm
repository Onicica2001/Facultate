bits 32 

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    
    a db 3
    b db 1
    c db 5
    d db 1
    r resd 1

segment code use32 class=code
    start:
        ; (a-b)+(c-b-d)+d
        
        mov eax,0
        
        mov al, [a]
        sub al,[b]
        
        mov ebx,0
        mov bl,[c]
        sub bl,[b]
        sub bl,[d]
        
        add eax,ebx
        
        add eax,[d]
        
        mov [r],eax
        
    
        push    dword 
        call    [exit]
