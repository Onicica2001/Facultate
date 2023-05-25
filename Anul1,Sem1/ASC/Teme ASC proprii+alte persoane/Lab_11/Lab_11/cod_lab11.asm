bits 32
extern exit, printf, scanf, gets                
import exit msvcrt.dll    
import printf msvcrt.dll
import gets msvcrt.dll                        
segment code use32 public code
global cod

cod:  
    mov eax, [esp + 4]
    push dword mesaj_1
    call [printf]
    add esp, 4*1
    push dword prop
    call [gets]
    add esp, 4*1
        
    mov esi, prop
    cld
    mov ecx,len
    mov ebx,0       ;in EBX vom retine numarul de litere din cuvant
    repeta:
        lodsb
        cmp al,''
        je spatiu
        inc ebx
        jecxz Final
        loop repeta
    spatiu:
        push ebx
        call [printf]
        add esp, 4*1
        mov ebx,0
        jmp repeta
    ret 4
