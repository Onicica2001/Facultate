bits 32 

segment code use32 public code

global maxim

maxim:
    mov ecx, [esp+8]
    mov esi, [esp+4]
    lodsd ; luam primul numar pentru a-l compara cu restul
    mov ebx, eax
    dec ecx
    cld
    repeta:
        lodsd ; luam pe rand elementele sirului
        cmp eax,ebx
        jng mic
        
        ; daca sunt mai mari, le salvam in ebx
        mov ebx, eax
        
        mic:
    loop repeta
    
    ret 8