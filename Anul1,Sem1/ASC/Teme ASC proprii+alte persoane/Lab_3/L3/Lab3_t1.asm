bits 32 


global  start 


extern  exit

 
import  exit msvcrt.dll;

;a - byte, b - word, c - double word, d - qword
segment  data use32 class=data 
	a db 10
	b dw 20
	c dd 50
	d dq 30
;5.(c-a-d)+(c-b)-a     INTERPRETARE FARA SEMN
segment  code use32 class=code 
start: 
        ; c-a
        mov al, [a]
        mov ah, 0 ; conversie AL->AX
        mov dx, 0 ; conversie AX->DX:AX
        push dx
        push ax
        pop ebx   ; in EBX se afla continutul lui a in dd
        mov eax,[c]
        sub eax,ebx ; in EAX este rezultatul scaderii c-a
        ; c-a-d
        mov edx,0 ; conversie EAX->EDX:EAX
        sub eax, [d]
        sbb edx, [d+4]
        ;c-b
        mov bx, [b]
        mov cx, 0
        push cx
        push bx
        pop ebx
        mov ecx,[c]
        sub ecx,ebx
        ;(c-a-d)+(c-b)
        mov ebx,0  ; in EBX:ECX este rezultatul c-b
        add eax,ecx
        adc edx,ebx ;in EDX:EAX este rezultatul(c-a-d)+(c-b)
        ;(c-a-d)+(c-b)-a
        mov cl,[a]
        mov ch,0
        mov bx,0
        push bx
        push cx
        pop ecx
        mov ebx,0 ; in EBX:ECX este a
        sub eax,ecx
        sbb edx,ebx
        ; rezultatul e in EDX:EAX
        
        push dword 0 
        call [exit] 