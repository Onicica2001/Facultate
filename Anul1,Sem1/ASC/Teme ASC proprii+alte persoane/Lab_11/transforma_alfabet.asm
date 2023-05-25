bits 32 

extern printf 
import printf msvcrt.dll 

segment data use32 class=data
    f db "Sir: %s", 0

segment data use32 public code

global transform

transform:
        mov ecx, 100
        mov esi, [esp + 4]
        mov edi, [esp + 8]
        mov edx, [esp + 12]
        cld
        repeta:
            mov eax, 0
            lodsb  
            sub al, 'a'
            mov ebx, [edx + eax]
            mov al, bl
            stosb
        loop repeta
        ret 
        