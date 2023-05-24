bits 32

global common_suffix

segment data use32 class=data public:
    sol times 101 db 0

segment code use32 class=code public:
common_suffix:
    ;esp+4: adresa primului sir
    ;esp+8: adresa celui de al doilea sir
    ;esp+12; lungimea minima dintre cele 2 siruri
    
    mov edi, sol
    mov al, 0
    mov ecx, 100
    rep stosb ; golim sirul sol
    
    mov ecx, [esp+12]
    dec ecx
    cld; df <- 0 (parcurgem sirul de la dreapta la stanga)
    
    mov ebx, [esp+4]; esi <- adresa primului sir
    mov edx, [esp+8]; edi <- adresa celui de-al doilea sir
    
    mov edi, sol
    
    repeta:
        mov al, [ebx]
        mov ah, byte [edx]
        inc ebx
        inc edx
        cmp al, ah
        je egale
        mov edi, sol
        loop repeta
        egale:
        stosb
        loop repeta
    final:
        mov [edi], byte 10
        mov [edi+1], byte 0
        mov eax, sol
        ret