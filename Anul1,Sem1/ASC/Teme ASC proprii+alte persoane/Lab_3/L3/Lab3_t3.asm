bits 32 


global  start 


extern  exit

 
import  exit msvcrt.dll;

; a-doubleword; b-byte; c-word; x-qword
segment  data use32 class=data 
	a dd 32
	b db 18
	c dw 2
	x dq 1
;5.(a+b/c-1)/(b+2)-x INTERPRETAREA FARA SEMN
segment  code use32 class=code 
start: 
        ;b/c
        mov al,[b]
        mov ah,0
        mov dx,0 ; DX:AX->b
        div word[c] ; AX->b/c (catul)
        
        ;a+b/c-1
        mov dx,0
        push dx
        push ax
        pop eax ;EAX->b/c
        add eax,[a] ; EAX->a+b/c
        sub eax,1 ;EAX->a+b/c-1
        
        ;(a+b/c-1)/(b+2)
        mov bl,[b]
        add bl,2
        mov bh,0   ;BX-> b+2
        div bx ; AX->(a+b/c-1)/(b+2)(catul)
        
        ;(a+b/c-1)/(b+2)-x
        mov dx,0
        push dx
        push ax
        pop eax
        mov edx,0 ; EDX:EAX->(a+b/c-1)/(b+2)
        sub eax,[x]
        sbb edx,[x+4]
        ;rezultatul este in EDX:EAX
        push dword 0 
        call [exit] 