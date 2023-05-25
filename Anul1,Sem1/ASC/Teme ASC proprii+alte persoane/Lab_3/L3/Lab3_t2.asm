bits 32 


global  start 


extern  exit

 
import  exit msvcrt.dll;

;a - byte, b - word, c - double word, d - qword
segment  data use32 class=data 
	a db -10
	b dw -20
	c dd 50
	d dq 30
;5.(c+b+b)-(c+a+d)     INTERPRETARE CU SEMN
segment  code use32 class=code 
start: 
        ;b+b
        mov ax,[b]
        add ax,[b]
        cwde ;EAX->b+b
        
        ;c+b+b
        add eax,[c] ;EAX->c+b+b
        mov ebx,eax ;EBX->c+b+b
        
        ;c+a
        mov al,[a]
        cbw
        cwde ;EAX->a
        add eax,[c] ;EAX->c+a
        
        ;c+a+d
        cdq ;EDX:EAX->c+a
        add eax,[d]
        adc edx,[d+4] ;EDX:EAX->c+a+d
        
        ;(c+b+b)-(c+a+d) 
        push ebx ;c+b+b pe stiva
        mov ecx,eax
        mov ebx,edx ;EBX:ECX->c+a+d
        pop eax ;EAX->c+b+b
        cdq  ;EDX:EAX->c+b+b
        sub eax,ecx
        sbb edx,ebx
        ; rezultatul este in EDX:EAX
        push dword 0 
        call [exit] 