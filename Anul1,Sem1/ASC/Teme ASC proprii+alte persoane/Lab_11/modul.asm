bits 32
global cifra

segment code use32 class=code
        
    cifra:
        ; primeste pe stiva la pozitia esp+4 un numar
        ; pune in eax cifra sutelor numarului
        
        xor edx, edx
        mov eax, [esp+4]
        mov ebx, 100
        div ebx
        xor edx, edx
        mov ebx, 10
        div ebx
        mov eax, edx
        ret