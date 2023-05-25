bits 32
global start        


extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    ; ...
;a - byte, b - word, c - double word, d - qword - Interpretare cu semn
;(c+d-a)-(d-c)-b //20 - 5 - 5 = 10
a db 5
b dw 5
c dd 10
d dq 15
; our code starts here
segment code use32 class=code
    start:
        ; ...
        xor eax, eax ; initializam registrul eax 
        mov EAX,[c] ;adaugam valoarea lui c in registru
        cdq
        
        xor ebx, ebx ; initializam registrul ebx 
		xor ecx, ecx ;initializam registrul ecx
        mov ebx, [d] 
		add ecx, [d+4] ;ecx:ebx=d
        add ebx, eax
        adc ecx, edx 
;ebx:ecx =c+d
        xor eax, eax 
        xor edx, edx 
        mov al, [a]
        cbw
        cwd
        cdq
        sub ebx, eax
        sbb ecx, edx 
;ebx:ecx=c+d-a
        push ebx
        push ecx
        
        xor ebx, ebx ; initializam registrul ebx 
		xor ecx, ecx ;initializam registrul ecx
        mov ebx, [d] 
		add ecx, [d+4] 
;ecx:ebx=d
        xor eax, eax ; initializam registrul eax
        mov EAX,[c] ;adaugam valoarea lui c in registru
        cdq
;eax=c
        sub ebx, eax
        sbb ecx, edx
;ecx:ebx=d-c
        xchg eax,ebx
        xchg edx,ecx
        
        xor ebx, ebx ; initializam registrul ebx 
		xor ecx, ecx ;initializam registrul ecx
        mov ebx,eax
        mov ecx,edx
;ecx:ebx=d-c

        xor eax,eax
        xor edx,edx
        pop edx
        pop eax
;edx:eax
        sub eax,ebx
        sbb edx,ecx
;edx:eax= (c+d-a) - (d-c)
        
        xchg eax,ebx
        xchg edx,ecx
;ecx:ebx= (c+d-a) - (d-c)     

        xor eax, eax ; initializam registrul eax
        xor edx, edx
        mov al,[b] ;adaugam valoarea lui c in registru
        cbw
        cwd
        cdq
;edx:eax = b

        sub ebx,eax
        sbb ecx,edx


        
; exit(0)
        push    dword 0      
        call    [exit]       
