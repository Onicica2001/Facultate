bits 32
global start
extern exit
import exit msvcrt.dll

; a,b-byte, c-word, e-doubleword, x-qword, interpretare cu semn
segment data use32 class=data
    a db -10
    b db -4
    c dw -10
    e dd -4
    x dq -5

segment code use32 class=code
    start:
        ; (a-b+c*128)/(a+b)+e-x
        mov eax, 0
        mov ax, [c]                         ; ax = c
        mov bx, 128                         ; bx = 128
        imul bx                             ; dx:ax = ax * bx = c*128
        push dx
        push ax
        pop ebx                             ; ebx = c * 128
        
        mov al, [a]
        cbw                                 ; ax = a
        mov cx, ax                          ; cx = a
        mov al, [b]
        cbw                                 ; ax = b
        sub cx, ax                          ; cx = a - b
        mov ax, cx
        cwde                                ; eax = a - b
        
        mov edx, 0
        add eax, ebx
        cdq                                 ; edx:eax = a-b+c*128
        mov ecx, eax                        ; edx:ecx = a-b+c*128
        
        mov al, [a]
        cbw
        mov bx, ax                          ; bx = a
        mov al, [b]
        cbw                                 ; ax = b
        add ax, bx                          ; ax = a + b
        cwde                                ; eax = a + b
        mov ebx, eax                        ; ebx = a + b
        mov eax, ecx                        ; edx:eax = a-b+c*128
        
        idiv ebx                            ; eax = edx:eax / ebx = (a-b+c*128)/(a+b), edx = edx:eax % ebx
        mov edx, 0
        add eax, [e]                        ; edx:eax = eax + e = (a-b+c*128)/(a+b) + e
        cdq
        
        mov ebx, dword [x]
        mov ecx, dword [x+4]                ; ecx:ebx = x
        sub eax, ebx
        sbb edx, ecx                        ; edx:eax = edx:eax - ecx:ebx = (a-b+c*128)/(a+b) + e - x
        
        
        push    dword 0
        call    [exit]
