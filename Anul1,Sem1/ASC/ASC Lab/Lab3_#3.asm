bits 32 


global start        


extern exit               
import exit msvcrt.dll    

;  a-word; b,c,d-byte; e-doubleword; x-qword Interpretare fara semn
segment data use32 class=data
    a dw 0FFFFh 
    b db 160
    c db 109
    d db 59
    e dd 5000
    x dq 0FFFFFEh

; (a*2+b/2+e)/(c-d)+x/a
segment code use32 class=code
    start:
        ;calculam x/a
        mov ax,[a]          ;AX=a=FFFFh
        mov dx,0
        push dx
        push ax
        pop ecx             ;ECX=DX:AX=FFFFh
        mov eax,dword[x]    ;EAX=FFFFFFh
        mov edx,dword[x+4]  ;EDX=0
        div ecx             ;EAX=EDX:EAX/ECX=FFFFFFh/FFFFh=100h=256d
        mov ecx,eax         ;ECX=EAX=100h=256d
        
        ;calculam a*2
        mov ax,[a]          ;AX=a=FFFFh
        mov dx,2            ;DX=2
        mul dx              ;DX:AX=AX*DX=FFFFh*2=1FFFEh
        push dx
        push ax
        pop ebx             ;EBX=1FFFEh
        
        ;calculam b/2
        mov al,[b]          ;AL=b=A0h=160d
        mov ah,0            
        mov dl,2
        div byte dl         ;AL=AX/DL=50h=80d
        mov ah,0
        mov dx,0
        push dx
        push ax
        pop eax             ;EAX=50h=80d
        
        ;calculam a*2+b/2
        add eax,ebx         ;EAX=EAX+EBX=50h+1FFFEh=2004Eh=131150d
        
        ;calculam a*2+b/2+e
        mov ebx,[e]         ;EBX=e=1388h=5000d
        add eax,ebx         ;EAX=EAX+EBX=2004Eh+1388h=213D6h=136150d
        
        ;calculam c-d
        mov bl,[c]          ;BL=c=6Dh=109d
        mov dl,[d]          ;DL=d=3Bh=59d
        sub bl,dl           ;BL=BL-DL=6Dh-3Bh=32h=50d
        
        ;calculam (a*2+b/2+e)/(c-d)
        mov bh,0
        push eax            
        pop ax
        pop dx
        div word bx         ;AX=DX:AX/BX=213D6h/32h=AA3h=2723d
        
        ;calculam (a*2+b/2+e)/(c-d)+x/a
        mov dx,0
        push dx
        push ax
        pop eax
        add eax,ecx         ;EAX=EAX+ECX=AA3h+100h=BA3h=2979d
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
