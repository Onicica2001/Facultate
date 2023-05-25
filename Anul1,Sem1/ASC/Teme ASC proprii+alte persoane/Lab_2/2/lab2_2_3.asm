bits 32 
global start        

extern exit               
import exit msvcrt.dll   

segment data use32 class=data
    ; ...
;(c+b)-a-(d+d) word
a dw 1
b dw 2
c dw 3
d dw 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov eax, 0
	mov ax, [c]
	add ax, [b]
	;(c+b)
	sub ax, [a]
	;(c+b)-a
	mov ebx, 0
	mov bx, [d]
	add bx, [d]
	;(d+d)
	sub ax, bx
	;(c+b)-a-(d+d)
	; exit(0)
        push    dword 0      
        call    [exit]       
