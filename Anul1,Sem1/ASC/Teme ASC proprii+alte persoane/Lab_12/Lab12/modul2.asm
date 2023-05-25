bits 32 

extern _strcat
extern _printf

global _concatenare

segment data public data use32
    sir_final dd 0

segment code public use32
_concatenare:
        push ebp
        mov ebp, esp
        
        mov eax, [ebp+16]
        mov ebx, [ebp+12]
        
        push eax
        push ebx
        call _strcat
        add esp, 4*2
        
        mov ebx, eax
        mov eax, [ebp+8]
        
        push ebx
        push eax
        call _strcat
        add esp, 4*2
        
        push eax
        call _printf
        add esp, 4*1
        
        mov esp, ebp
        pop ebp
    ret