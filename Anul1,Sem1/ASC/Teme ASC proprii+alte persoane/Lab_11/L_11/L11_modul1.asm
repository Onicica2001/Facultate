bits 32                         
segment code use32 public code
global dublate

dublate:
        mov ecx, [esp+4]
        mov ecx, [ecx]
        mov ebx, [esp+12]
        lea esi, [ebx+ecx*4-4]
        mov edi, 0
        .repeta:
            mov eax, dword[esi]
            mov ebx, 2
            mul ebx
            ;edx:eax =nr*2
            mov edx, [esp+8]
            mov [edx+edi*4],eax
            inc edi
            sub esi, 4
        loop .repeta
        ret 4*3