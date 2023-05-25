bits 32 

global start        


extern exit               
import exit msvcrt.dll    
                          
; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
segment data use32 class=data
    a db 0FFh
    b dw 0AAh
    c dd 0FFFEEDBAh
    d dq 0EEEEAAAAh

; (a-b)+(c-b-d)+d
segment code use32 class=code
    start:
        ;calculam c-b
        mov ax,word[c]      ;AX=EDBAh
        mov dx,word[c+2]    ;DX=FFFEh
        mov bx,word[b]      ;BX=AAh
        mov cx,0            
        sub ax,bx           ;AX=AX-BX=EDBAh-AAh=ED10h
        sbb dx,cx           ;DX=DX-CX-CF=FFFEh-0-0=FFFEh                    CF=0
        push dx
        push ax
        pop eax             ;EAX=FFFEED10h
        
        ;calculam c-b-d
        mov edx,0           
        mov ebx,dword[d]    ;EBX=EEEEAAAAh
        mov ecx,dword[d+4]  ;ECX=0
        sub eax,ebx         ;EAX=EAX-EBX=FFFEED10h-EEEEAAAAh=11104266h      CF=0
        sbb edx,ecx         ;EDX=EDX-ECX-CF=0-0-0=0
        
        ;calculam (c-b-d)+d
        mov ebx,dword[d]    ;EBX=EEEEAAAAh
        mov ecx,dword[d+4]  ;ECX=0
        add eax,ebx         ;EAX=EAX+EBX=FFFEED10h+EEEEAAAAh=EEED97BAh      CF=1
        adc edx,ecx         ;EDX=EDX+ECX+CF=0+0+1=1
        
        ;calculam a-b
        mov bl,[a]          ;BL=a=FFh
        mov bh,0            
        mov cx,[b]          ;CX=b=AAh
        sub bx,cx           ;BX=BX-CX=FFh-AAh=55h
        mov cx,0
        push cx
        push bx
        pop ebx             ;EBX=55h
        mov ecx,0
        
        ;calculam (a-b)+(c-b-d)+d
        add eax,ebx         ;EAX=EAX+EBX=11104266h+55h=111042BBh            CF=0
        adc edx,ecx         ;EDX=EDX+ECX+CF=1+0+0=1
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
