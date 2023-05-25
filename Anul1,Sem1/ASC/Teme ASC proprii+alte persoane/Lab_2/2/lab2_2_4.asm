bits 32 
global start        

extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    ; ...
;a,b,c - byte, d - word
;d*(d+2*a)/(b*c)
a db 2
b db 3
c db 4
d dw 7
segment code use32 class=code
    start:
        ; ...
    mov eax, 0
	mov al,[a]
    mul ax
	add ax, [d]
	mul word [d]
;d*(d+2*a)=eax
	mov ebx, 0
	mov ebx, eax
;eax=ebx
	mov eax, 0
	mov al, [b]
	mul byte [c]
;(b*c)=eax
	div ebx
    ; exit(0)
        push    dword 0      
        call    [exit]       