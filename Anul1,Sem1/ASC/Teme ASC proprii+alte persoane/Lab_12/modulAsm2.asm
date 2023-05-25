bits 32

global _afisare
extern _printf

segment data public data use32
    format1 db '%3d     %3o     %c', 10, 13, 0

segment code public code use32

_afisare:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    times 3 push eax
    push dword format1
    call _printf
    add esp, 4*4
    
    mov esp, ebp
    pop ebp
    ret