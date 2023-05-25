bits 32

global start        

extern exit
import exit msvcrt.dll

;Se dau cuvintele A, B si C. Sa se obtina octetul D ca suma a numerelor reprezentate de:
;biţii de pe poziţiile 0-4 ai lui A
;biţii de pe poziţiile 5-9 ai lui B
;Octetul E este numarul reprezentat de bitii 10-14 ai lui C. Sa se obtina octetul F ca rezultatul scaderii D-E.

segment data use32 class=data

a dw 000010100101111b
b dw 010100010110101b
c dw 001010100011010b
d resw 1
e resb 1
f resb 1  
    
segment code use32 class=code
    start:
        xor eax, eax
        xor ebx, ebx
        mov ax, [a]
        and ax, 0000000000011111b
        mov bx, [b]
        and bx, 0000001111100000b
        shr bx, 5
        
        add ax, bx
        mov [d], al
        xor eax, eax
        mov ax, c
        and ax, 0111110000000000b
        shr ax, 10
        mov [e], al
        
        xor eax, eax
        xor ebx, ebx
        
        mov al, [d]
        sub al, [e]
        
        mov [f], al
        
        push    dword 0
        call    [exit]
