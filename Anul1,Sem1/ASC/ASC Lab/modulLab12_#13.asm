bits 32

global _common_suffix

segment data use32 class=data public:
    sol times 101 db 0

segment code use32 class=code public:
_common_suffix:
    ;ebp+8: adresa primului sir
    ;ebp+12: adresa celui de al doilea sir
    ;ebp+16; lungimea minima dintre cele 2 siruri
    ;ebp+20; adresa sir rez
    
    push ebp
    mov ebp,esp
    
    pushad
    
    mov ecx, [ebp+16]
    cld; df <- 0 (parcurgem sirul de la dreapta la stanga)
    
    mov ebx, [ebp+8]; ebx <- adresa primului sir
    mov edx, [ebp+12]; edx <- adresa celui de-al doilea sir
    
    mov edi, [ebp + 20]
    
    repeta:
        mov al, [ebx]
        mov ah, byte [edx]
        inc ebx
        inc edx
        cmp al, ah
        je egale
        mov edi, [ebp+20]
        loop repeta
        egale:
        stosb
        loop repeta
    final:
        mov [edi], byte 10
        mov [edi+1], byte 0
        ;mov eax, sol
    
    popad
    
    ;mov eax,sol
    
    mov esp,ebp
    pop ebp
    ret