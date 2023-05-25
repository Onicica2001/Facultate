bits 32 


global start        


extern exit              
import exit msvcrt.dll    

; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
segment data use32 class=data
    a db 127
    b dw 2000
    c dd -350
    d dq 1000

; (b+b)-c-(a+d)
segment code use32 class=code
    start:
        ;calculam a+d
        mov al,[a]          ;AL=a=7Fh=127d
        cbw                 ;AL->AX
        cwde                ;AX->EAX
        cdq                 ;EAX->EDX:EAX       EAX=7Fh=127d
        mov ebx,dword[d]    ;EBX=3E8h=1000d
        mov ecx,dword[d+4]  ;ECX=0
        add eax,ebx         ;EAX=EAX+EBX=7Fh+3E8h=467h=1127d        CF=0
        adc edx,ecx         ;EDX=EDX+ECX+CF=0+0+0=0
        mov ebx,eax         ;EBX=EAX=467h=1127d
        mov ecx,edx         ;ECX=EDX=0
        
        ;calculam b+b
        mov ax,[b]          ;AX=b=7D0h=2000d
        add ax,ax           ;AX=AX+AX=FA0h=4000d
        
        ;calculam (b+b)-c
        cwde                ;AX->EAX
        mov edx,[c]         ;EDX=c=FFFF FEA2h=-350d
        sub eax,edx         ;EAX=EAX-EDX=FA0h-FFFF FEA2h=10FEh=4350d
        
        ;calculam (b+b)-c-(a+d)
        cdq                 ;EAX->EDX:EAX
        sub eax,ebx         ;EAX=EAX-EBX=10FEh-467h=C97h=3223d      CF=0
        sbb edx,ecx         ;EDX=EDX-ECX-CF=0-0-0=0
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
