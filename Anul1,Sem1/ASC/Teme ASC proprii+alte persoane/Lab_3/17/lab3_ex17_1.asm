bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
a db 5
b dw 5
c dd 10
d dq 15
; our code starts here
segment code use32 class=code
    start:
        ; ...
	;(c+c-a)-(d+d)-b
	xor eax, eax ; intializam registrul eax 
        mov EAX,[c] ;adaugam valoarea lui c in registru
        add EAX, [c] ;c+c 
		sub al, [a] ;c+c-a

		xor ebx, ebx ; initializam registrul ebx 
		xor ecx, ecx ;initializam registrul edx
        mov ebx, [d] 
		add ecx, [d+4]
		add ecx, ecx
		adc ebx, ebx
		
		cdq
        sub eax, ebx;(c+c-a)-(d+d)
		sbb edx, ecx 
		
		sub AL, [b] ;(c+c-a)-(d+d)-b
		;rezultatul este in AL 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
