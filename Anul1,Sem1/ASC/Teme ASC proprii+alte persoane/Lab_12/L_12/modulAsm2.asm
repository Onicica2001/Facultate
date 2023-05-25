bits 32
extern _printf
global _afiseaza_baza2
segment data public data use32
    
    e_zero db "0", 0
    e_unu db "1", 0
    retine_ecx dd 0
    retine_eax dd 0
    
segment code public code use32
_afiseaza_baza2:
    
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
   
    mov ecx, 32
    jecxz final
    repeta:
    
        mov [retine_ecx], ecx
        mov [retine_eax], eax
        test eax, 80000000h                 ; testez daca primul bit este 1
        jz nu_este_1
        
        push dword e_unu                    ; daca e 1, afisez 1
        call _printf
        add esp, 4
        jmp continuare
        
        nu_este_1:
            push dword e_zero               ; daca e 0, afisez 0
            call _printf
            add esp, 4
        
        continuare:
            mov eax, [retine_eax]
            shl eax, 1                      ; rotesc eax, pentru a verifica urmatorul bit
            mov ecx, [retine_ecx]
           
    
    loop repeta
    
    final:
    pop ebp
	ret