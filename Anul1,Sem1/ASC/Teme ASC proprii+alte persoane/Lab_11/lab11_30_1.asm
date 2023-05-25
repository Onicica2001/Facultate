bits 32

global start
extern inverseaza_cuvinte

extern exit, gets, puts
import exit msvcrt.dll
import gets msvcrt.dll
import puts msvcrt.dll

segment data use32 class=data
    cuvinte resb 100
    
segment code use32 class=code
start:
    push cuvinte
    call [gets]
    add esp, 4
    
    push cuvinte
    call inverseaza_cuvinte
    add esp, 4

    push cuvinte
    call [puts]
    add esp, 4
    

    push dword 0
    call [exit]