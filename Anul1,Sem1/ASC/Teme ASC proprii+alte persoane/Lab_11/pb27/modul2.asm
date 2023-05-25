bits 32 
       
extern printf
import printf msvcrt.dll


segment data use32 class=data

        format_afisare db ' %d', 0              ; formatul de afisare la consola   
        x dw 4
        
segment code use32 public code
global modul

    modul:
    
        mov ebx, [esp + 8]
        mov eax, ebx
        div word [x]
        mov ecx, eax
        jecxz final
        cld
        mov esi, [esp + 4]
        
        afisare:
        
            push ecx
            lodsd
            
            push eax
            push dword format_afisare
            call [printf]
            add esp, 4 * 2
            
            pop ecx
           
        loop afisare                                ; afisam pe rand numerele pare/impare

        final:
        
        ret 4 * 2
