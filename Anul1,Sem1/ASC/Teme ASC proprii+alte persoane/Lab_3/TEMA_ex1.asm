bits 32
global start
extern exit
import exit msvcrt.dll

; a - byte, b - word, c - double word, d - qword, interpretare fara semn
segment data use32 class=data
    a db 2
    b dw 3
    c dd 6
    d dq 10

segment code use32 class=code
    start:
        ; (d+d-b)+(c-a)+d
        mov eax, dword [d]
        mov edx, dword [d+4]        ; edx:eax = d
        add eax, eax
        adc edx, edx                ; edx:eax = d + d
        
        mov ebx, 0
        mov bx, [b]                 ; ebx = b
        sub eax, ebx
        sbb edx, 0                  ; edx:eax = d + d - b        
        
        mov ebx, [c]                ; ebx = c
        mov ecx, 0
        mov cl, [a]                 ; ecx = a
        sub ebx, ecx                ; ebx = ebx - ecx = c - a        
        
        add eax, ebx
        adc edx, 0                  ; edx:eax = edx:eax + ebx = (d + d - b) + (c - a)
        
        add eax, dword [d]
        adc edx, dword [d+4]        ; edx:eax = (d + d - b) + (c - a) + d
    
        
        push    dword 0
        call    [exit]
