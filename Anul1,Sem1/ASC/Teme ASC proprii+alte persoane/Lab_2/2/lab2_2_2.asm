bits 32 
global start        

extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    ; ...
;(b+b)+(c-a)+d
a db 1
b db 2
c db 3
d db 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov eax, 0
	mov al, [b]
	add al, [b]
	; (b+b)=4
	mov ebx, 0
	mov bl, [c]
	sub bl, [a]
	;(c-a)=2
	add al, bl
	;(b+b)+(c-a) =6
	add al, [d]
	;(b+b)+(c-a)+d=10
        ; exit(0)
        push    dword 0      
        call    [exit]       
