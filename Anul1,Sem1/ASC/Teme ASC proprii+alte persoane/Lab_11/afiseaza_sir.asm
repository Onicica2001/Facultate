bits 32 
  
extern printf
import printf msvcrt.dll  

global afiseaza_sir

segment data use32 class=data
    format db "Sirul transformat este: %s", 0

segment code use32 public code

afiseaza_sir:
    mov eax, [esp + 4]
    push eax
    push dword format
    call [printf]
    add esp, 4*2
    
    ret
    
         
