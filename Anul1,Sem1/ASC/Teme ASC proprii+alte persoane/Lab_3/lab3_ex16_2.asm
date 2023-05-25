bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 5
    c dd 10
    d dq 20
;(d-a)-(a-c)-d = (20 - 5) - (5 - 10) - 20 = 15 + 5 - 20
segment code use32 class=code
    start:
        
        mov al, [a]
        cbw
        cwde
        cdq
        
        mov ebx, [d]
        mov ecx, [d + 4]
        ; d-a
        sub ecx, edx
        sbb ebx, eax
        
        mov al, [a]
        cbw
        cwde
        ; a-c
        sub eax, dword[c]
        cdq
        ; (d-a)-(a-c)
        sub ecx, edx
        sbb ebx, eax
        ; (d-a)-(a-c)-d
        sub ecx, dword[d + 4]
        sbb ebx, dword[d]
        
        push    dword 0
        call    [exit] 
