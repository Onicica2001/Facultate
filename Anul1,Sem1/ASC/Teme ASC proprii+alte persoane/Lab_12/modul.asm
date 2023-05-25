bits 32

extern _printf

global _longestPrefix

segment data public data use32
    sirRez        resb  100 
    adresaSir1    dd    0
    adresaSir2    dd    0
    char          db    "%c" ,0
    sir           db    "%s ", 0

segment code public code use32
_longestPrefix:
    push ebp
    mov ebp, esp
    sub esp, 4
    
    ; cod
    mov eax, [ebp + 8]
    mov [adresaSir1], eax
    mov eax, [ebp + 12]
    mov [adresaSir2], eax
    
    mov ecx, 10
    mov esi, 0
    .repet:
        mov eax, 0
        mov ebx, [adresaSir1]
        mov al, [ebx + esi]
        
        mov edx, 0
        mov ebx, [adresaSir2]
        mov dl, [ebx + esi]
                
        cmp eax, edx
        jnz .final
        
        pushad 
        push dword edx
        push dword char
        call _printf
        add esp, 4*2
        popad
        
        inc esi
        loop .repet
    
    .final:
    
    add esp, 4
    mov esp, ebp
    pop ebp
ret