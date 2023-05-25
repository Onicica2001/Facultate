bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global modificare    

extern fclose, fopen, fprintf

import fopen msvcrt.dll 
import fclose msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    cif dd 0
    tabela db '0123456789ABCDEF', 0
    fisier db "min.txt", 0
    mod_acces db "w", 0
    des dd -1
    


; our code starts here
segment code use32 class=code

    modificare:
    
    push dword mod_acces        ; Deschidem fisierul 
    push dword fisier
    call [fopen] 
    add esp, 4*2 
    
    mov [des], eax 
    
    cmp eax, 0
    je final 
    
    mov esi, [esp + 4]          ; In esi punem offset-ul 
                                ; lui min 
    
    scriere:
    cmp si, 4095 
    je final 
    
    mov dl, 16                  ; Executam translatarea minimului
    mov ebx, tabela             ; in baza 16 
    xor eax, eax 
    lodsb 
    div dl
    xlat 
    mov [cif], al
    
    push dword cif             ; Scriem cifra corespunzatoare din baza 16 
    push dword [des]           ; in fisier
    mov ebx, eax  
    call [fprintf]
    mov eax, ebx 
    mov ebx, tabela
    mov al, ah
    xlat    
    mov [cif], al              ; Scriem cifra corespunzatoare din baza 16 
    push dword cif             ; in fisier
    push dword [des] 
    call [fprintf]
    add esp, 4*4 
    
    sub esi, 2
    
    jmp scriere
    
    final:
    push dword [des]          ; Inchidem fisierul 
    call [fclose]
    add esp, 4*1 
    
    ret 
    
    
