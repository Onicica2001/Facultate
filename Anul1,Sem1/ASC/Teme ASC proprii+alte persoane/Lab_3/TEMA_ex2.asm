bits 32
global start        
extern exit
import exit msvcrt.dll

; a - byte, b - word, c - double word, d - qword, interpretare cu semn
segment data use32 class=data
    a db 10
    b dw 7
    c dd 3
    d dq -20

segment code use32 class=code
    start:
        ; a-d+b+b+c
        mov eax, 0
        mov al, [a]
        cbw
        cwde                        ; eax = a
        cdq                         ; edx:eax = a
        mov ebx, 0
        sub eax, dword [d]
        sbb edx, dword [d+4]        ; edx:eax = a - d
        
        mov ebx, eax
        mov ecx, edx                ; ecx:ebx = a - d
        mov eax, 0
        mov ax, [b]
        cwde                        ; eax = b
        cdq                         ; edx:eax = b
        add ebx, eax
        adc ecx, edx                ; ecx:ebx = a - d + b
        
        add ebx, eax
        adc ecx, edx                ; ecx:ebx = a - d + b + b
        
        mov eax, [c]                ; eax = c
        cdq                         ; edx:eax = c
        add ebx, eax
        adc ecx, edx                ; ecx:ebx = a - d + b + b + c
        
        push    dword 0
        call    [exit]
