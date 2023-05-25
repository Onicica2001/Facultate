bits 32
global start
extern exit
import exit msvcrt.dll

; a,b-byte, c-word, e-doubleword, x-qword, interpretare fara semn
segment data use32 class=data
    a db 20
    b db 2
    c dw 3
    e dd 4
    x dq 5
    
segment code use32 class=code
    start:
        ; (a-b+c*128)/(a+b)+e-x
        mov ax, [c]                 ; ax = c
        mov bx, 128                 ; bx = 128
        mul bx                      ; dx:ax = ax * bx = c * 128
        push dx
        push ax
        pop eax                     ; eax = c * 128
        
        mov ebx, 0
        mov bl, [a]                 ; ebx = bl = a
        mov cl, [b]                 ; cl = b
        sub bl, cl                  ; ebx = bl - cl = a - b
        
        mov edx, 0
        add eax, ebx
        adc dl, 0                   ; edx:eax = eax + ebx = (a - b) + (c * 128)
        
        mov ebx, 0
        mov bl, [a]
        add bl, [b]
        adc bh, 0                   ; ebx = a + b
        
        div ebx                     ; eax = edx:eax / ebx = (a-b+c*128)/(a+b), edx = edx:eax % ebx
        mov edx, 0
        add eax, [e]
        adc edx, 0                  ; edx:eax = eax + e = (a-b+c*128)/(a+b) + e
        
        mov ebx, dword [x]
        mov ecx, dword [x+4]        ; ecx:ebx = x
        
        sub eax, ebx
        sbb edx, ecx                ; edx:eax = edx:eax - ecx:ebx = (a-b+c*128)/(a+b) + e - x
        
        
        push    dword 0
        call    [exit]
