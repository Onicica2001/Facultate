bits 32 


global start        


extern exit               
import exit msvcrt.dll    

;  a-word; b,c,d-byte; e-doubleword; x-qword Interpretare cu semn
segment data use32 class=data
    a dw -10
    b db 24
    c db 13
    d db 3
    e dd 38
    x dq 0FFFFFFF6h

; (a*2+b/2+e)/(c-d)+x/a
segment code use32 class=code
    start:
        ;calculam x/a
        mov ax,[a]          ;AX=a=FFF6h=-10d
        cwde
        mov ecx,eax         ;ECX=EAX=FFFFFFF6h=-10d
        mov eax,dword[x]    ;EAX=FFFFFFF6h
        mov edx,dword[x+4]  ;EDX=0
        idiv ecx            ;EAX=EDX:EAX/ECX=FFFFFFF6h/FFFFFFF6h=E6666668h=-429496728d
        mov ecx,eax         ;ECX=EAX=E6666668h=-429496728d
        
        ;calculam a*2
        mov ax,[a]          ;AX=a=FFF6h=-10d
        mov dx,2            ;DX=2
        imul dx             ;DX:AX=AX*DX=FFF6h*2=FFFFFFECh=-20d
        push dx
        push ax
        pop ebx             ;EBX=FFFFFFECh=-20d
        
        ;calculam b/2
        mov al,[b]          ;AL=b=18h=24d
        cbw           
        mov dl,2
        idiv dl             ;AL=AX/DL=Ch=12d
        cbw
        cwde                ;EAX=Ch=12d
        
        ;calculam a*2+b/2
        add eax,ebx         ;EAX=EAX+EBX=FFFFFFECh+Ch=FFFFFFF8h=-8d
        
        ;calculam a*2+b/2+e
        mov ebx,[e]         ;EBX=e=26h=38d
        add eax,ebx         ;EAX=EAX+EBX=FFFFFFF8h+26h=1Eh=30d
        mov ebx,eax         ;EBX=EAX=1Eh=30d
        
        ;calculam c-d
        mov al,[c]          ;AL=c=Dh=13d
        mov dl,[d]          ;DL=d=3
        sub al,dl           ;AL=AL-DL=Ah=10d
        
        ;calculam (a*2+b/2+e)/(c-d)
        cbw
        mov edx,eax         ;EDX=EAX=Ah=10d
        mov eax,ebx         ;EAX=EBX=1Eh=30d
        mov ebx,edx         ;EBX=EDX=Ah=10d
        push eax            
        pop ax
        pop dx
        idiv bx             ;AX=DX:AX/BX=1Eh/Ah=3h=3d
        
        ;calculam (a*2+b/2+e)/(c-d)+x/a
        cwde
        add eax,ecx         ;EAX=EAX+ECX=3h+E6666668h=E666666Bh=-429496725d
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
