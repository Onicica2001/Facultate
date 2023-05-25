bits 32 ; assembling for the 32 bits architecture
global e_prim 

segment code use32 class=code
 
    e_prim:                 ; int e_prim(N) { 1 pt N prim, 0 pt N neprim)
        mov eax, [esp + 4] 
        mov edx, 0 ; pun parametrul in edx: eax 
        mov ebx, eax  
        
        cmp eax,0
        je nu_e ; 0 nu e prim 
        
        cmp eax, 1  ; 1 nu e prim
        je nu_e 
        
        cmp eax, 2 ; 2 e prim
        je este
        and eax, 01h  ; eax e par 
        jz nu_e      ; atunci nu e prim
        
    ; for i = 3 ; i < N ; i += 2
            ; if N % i == 0:
                    ; return 0 
   ; return 1 
        mov ecx, 3                 
        repeta:
        
        ; test daca i == N ( nu s-a gasit niciun divizor, exceptand numarul insusi) 
        cmp ecx, ebx 
        je este 
        
        ; test daca s-a gasit un rest = 0        
        div ecx  ; EAX <-  EDX:EAX / ECX   ; EDX <- EDX:EAX % ECX 
        cmp edx, 0   
        je nu_e
        
        mov eax, ebx ; in ebx am parametrul nealterat dupa impartirie 
        mov edx, 0   ; readuc in edx:eax parametrul N
        inc ecx
        inc ecx       ; i += 2 
        jmp repeta 
        
        ; daca nu se sare pana aici la eticheta nu_e atunci numarul e prim
    este: 
        mov eax, 1 
        ret 4 

    nu_e: 
        mov eax, 0 
        ret 4 
