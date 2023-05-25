bits 32 
global start        
extern exit
import exit msvcrt.dll    
segment data use32 class=data
    ; ...
;a - byte, b - word, c - double word, d - qword - Interpretare fara semn
;c-a-(b+a)+c
a db 1
b dw 2
c dd 10
segment code use32 class=code
    start:
        ; ...
    mov eax,0
	mov al, [a]
	mov ebx, 0
	mov ebx, [c]
    ; c-a
	sub ebx, eax
	
	mov eax, 0
	mov eax, [b]
	mov ecx, 0
	mov cl, [a]
    ; c-a-(b+a)
	sub eax,ecx
    ; c-a-(b+a)+c
	add eax, [c]
        ; exit(0)
        push    dword 0      
        call    [exit]       
