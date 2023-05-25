bits 32

global _intercalare


segment data public data use32
    litere db "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",0
    adr_s1 dd 0
    adr_s2 dd 0
    adr_rez dd 0
    
segment code public code use32
_intercalare:
	push ebp
	mov ebp,esp
    
    ; preluam parametrii de pe stiva
    mov eax,[ebp+20]
    mov [adr_rez], eax
    
    mov eax,[ebp+16]
    mov [adr_s2],eax
    
    mov eax,[ebp+12]
    mov [adr_s1],eax
    
    mov ecx, [ebp+8]
    mov eax, 0
    
    ; parcurgem cele doua siruri 
    cld
    mov esi, 0
    mov edi, [adr_rez]    
	repeta:
        ; preluam un caracter din s1
        mov ebx,[adr_s1]
        add ebx, esi
        mov al, [ebx]
        
        ; verificam daca este litera si stocam caracterul in acest caz
        mov bl,al
        push esi
        push ecx 
        mov esi,litere
        mov ecx,52
        mov edx,1
        jmp verificare_caracter
        
       inapoi_1:
        pop ecx
        pop esi
        
       ; preluam un caracter din s2
        mov ebx,[adr_s2]
        add ebx, esi
        mov al, [ebx]
        
        ; verificam daca este litera si stocam caracterul in acest caz
        mov bl,al
        push esi
        push ecx 
        mov esi,litere
        mov ecx,52
        mov edx,2
        jmp verificare_caracter
        
       inapoi_2:
        pop ecx
        pop esi
        
        ; avansam in sir
        inc esi       
       loop repeta
     jmp final
    
    
    ; se verifica daca este litera
    verificare_caracter:
        lodsb
        cmp bl,al
        je litera
        loop verificare_caracter
        
    ; in cazul in care nu este litera se continua parcurgerea sirurilor   
    cmp edx,1
    je inapoi_1
    cmp edx,2
    je inapoi_2
    
    ; in cazul in care este litera se stocheaza si se revine la parcurgerea sirurilor
    litera:
        stosb
        cmp edx,1
        je inapoi_1
        cmp edx,2
        je inapoi_2
    
    final:
       
    mov esp, ebp
    pop ebp
    
    
    mov eax, 10
    ret     