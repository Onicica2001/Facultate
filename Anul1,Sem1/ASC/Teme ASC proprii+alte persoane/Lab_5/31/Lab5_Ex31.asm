bits 32


global start        


extern exit
import exit msvcrt.dll


segment data use32 class=data

S db '+','4','2','a','8','4','X','5'
len equ $ - S
D times len db 0
    
    
segment code use32 class=code
    start:

        mov ecx, len
        mov esi, 0
        mov ebx, 0
        jecxz Sfarsit
            ; 0 -> 48 | 9 -> 57
            Repeta:
                mov al, [S+esi]
                cmp al, '0' ; 34 - 30 = 4
                jb Mic
                cmp al, '9' ; 34 - 39 = -5
                jg Mare
                
                mov [D+ebx], al ; D[0] = 4
                inc ebx
                Mare:
                Mic:
                inc esi
            loop Repeta
        Sfarsit:
    
    
        push    dword 0
        call    [exit]
