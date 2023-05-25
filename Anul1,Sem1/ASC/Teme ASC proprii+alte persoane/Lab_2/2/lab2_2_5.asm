bits 32 
global start        

extern exit               
import exit msvcrt.dll   
segment data use32 class=data
    ; ...
;a,b,c,d-byte, e,f,g,h-word
;e-a*a
a db 2
e dw 8
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov eax, 0
	mov al,[a]
    mul byte [a]
	mov ebx, 0
	mov ebx, [e]
	sub ebx, eax 
	;rezultatul este in ebx
        ; exit(0)
        push    dword 0      
        call    [exit]       
