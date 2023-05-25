bits 32 
global start        

extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    ; ...
;1+15
a db 1
b db 15

segment code use32 class=code
    start:
        
    mov eax, 0
	mov al, [a]
	add al, [b] 
	
        ; exit(0)
        push    dword 0      
        call    [exit]      
