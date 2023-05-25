bits 32 

extern printf, scanf
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    format_w db "Introduceti un sir: ", 0
    format_r db "%s", 0

segment code use32 public code

global citeste_sir

citeste_sir:
    push dword format_w
    call [printf]
    add esp, 4*1
    
    mov ebx, [esp+4]
    push dword ebx
    push dword format_r
    call [scanf]
    add esp, 4*2
    
    ret 