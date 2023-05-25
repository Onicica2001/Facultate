bits 32 


global  start 


extern  exit

 
import  exit msvcrt.dll;

; a-doubleword; b-byte; c-word; x-qword
segment  data use32 class=data 
	a dd -30
	b db 18
	c dw -2
	x dq -1
;5.(a+b/c-1)/(b+2)-x INTERPRETAREA CU SEMN
segment  code use32 class=code 
start: 
        ;b/c
        mov al,[b]
        cbw
        cwde ; DX:AX->b
        idiv word [c] ; AX->b/c (catul)
        
        ;a+b/c-1
        cwde
        push dx
        push ax
        pop eax ;EAX->b/c
        add eax,[a] ; EAX->a+b/c
        sub eax,1 ;EAX->a+b/c-1
        
        ;(a+b/c-1)/(b+2)
        mov ebx,eax ;EBX->a+b/c-1
        mov al,[b]
        add al,2
        cbw         ;AX-> b+2
        mov cx,ax   ;CX->b+2
        mov eax,ebx ;EAX->a+b/c-1
        idiv word cx ; AX->(a+b/c-1)/(b+2)(catul)
        
        ;(a+b/c-1)/(b+2)-x
        cwde
        push dx
        push ax
        pop eax
        cdq      ; EDX:EAX->(a+b/c-1)/(b+2)
        sub eax,[x]
        sbb edx,[x+4]
        ;rezultatul este in EDX:EAX
        push dword 0 
        call [exit] 