bits 32
extern _printf
global _afiseaza_baza16
segment data public data use32
    
    format db "%x", 0
    
segment code public code use32
_afiseaza_baza16:
    
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]          ;in EAX retinem numarul care trebuie convertit si afisat
   
    push dword eax
    push dword format
    call _printf
    add esp, 4 * 2              ;se afiseaza numarul folosind formatul pentru numerele hexadecimale
    
    pop ebp
    
	ret