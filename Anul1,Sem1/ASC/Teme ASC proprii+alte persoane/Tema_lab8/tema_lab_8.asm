bits 32 
global start        

extern exit               
import exit msvcrt.dll    
segment data use32 class=data
  
;Se dau doua siruri de octeti s1 si s2. 
;Sa se construiasca sirul de octeti d,
;care contine pentru fiecare octet din s2 pozitia sa in s1, sau 0 in caz contrar

    sir1 db 33h, 55h, 19h, 46h
    len1 equ $-sir1
    sir2 db 33h, 21h, 7h, 13h, 27h, 19h, 55h, 1h, 46h 
    len2 equ $-sir2
    d times len2 db 0
    ; d = 1, 0, 0, 0, 0, 3, 2, 0, 4
    
segment code use32 class=code
    start:
     
    mov ecx, len2                       ;for1 se repeta de len2 ori
    jecxz for1_final
    mov edx, 0                          ;EDX = i
    cld
    for1:
        mov al, [sir2 + edx]            ;AL = sir2[i]   
        mov edi, sir1                   ;EDI = sir1
        mov bl, 0                       ;BL = j
        for2:
            cmp bl, len1               
            je for2_final               ;daca j == len1 iesim din for2
            scasb                       ;compara al cu EDI
            jne poz_gresita             ;daca nu gaseste val. lui AL in EDI
            
            ;daca sir2[i] == sir1[j]
            inc bl
            mov [d+edx], bl             ;d[i] = j + 1
            jmp for2_final
            
            poz_gresita:
                inc bl                  ;j = j + 1
                jmp for2
            
        for2_final:
        inc edx                         ;i = i + 1
    
    loop for1
    for1_final:
    
    
     
        push    dword 0     
        call    [exit]       
