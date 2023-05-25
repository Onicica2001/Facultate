bits 32 

global _afisare10  

segment data public data use32 
    nr10 dd 0

segment code public code use32 

;int afisare10(len,nrBaza16)
_afisare10:
    push ebp 
    mov ebp, esp 
     
    ; salvam in ecx lungimea numarului
    mov ecx, [ebp + 8]
    jecxz final
    
    ; salvam in esi adresa sirului
    mov esi, [ebp+12]
    mov dword [nr10], 0
    
    .repeta:
            mov eax, 0
            lodsb               ;AL=nrBaza16[i]
            
            mov edx, ecx
            mov ecx, edx
            jecxz .putere0
            
            ;transformam in baza 10 cu formula:
            ;AX=nrBaza16[i] * 16^(ECX-1)
            .ridicarePutere:
                mov ah, 16
                mul ah          
            loop .ridicarePutere
            
            .putere0:
                mov ecx, edx
                add [nr10], eax 
            
    loop .repeta
      
    mov eax, [nr10]

final:
    mov esp, ebp 
    pop ebp 
    ret
    