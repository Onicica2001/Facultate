bits 32 ; assembling for the 32 bits architecture


global start        


extern exit, printf, scanf             
import exit msvcrt.dll     
import printf msvcrt.dll     
import scanf msvcrt.dll

; 25. Sa se citeasca de la tastatura doua numere a si b (in baza 10) şi să se determine relaţia de ordine dintre ele (a < b, a = b sau a > b). Afisati ;     rezultatul în următorul format: "<a> < <b>, <a> = <b> sau <a> > <b>".
segment data use32 class=data
    a dd 0
    message db "a=",0
    format db "%d",0
    
    b dd 0
    message2 db "b=",0
    ;format2 db "%d",0
    
    rezultatul db " %c ",0
    mic db " < ",0
    egal db " = ",0
    mare db " > ",0
    
    c dd 0



segment code use32 class=code
    start:
        ;citim a 
        push dword message  ;punem pe stiva mesajul
        call [printf]       ; afis: a=
        add esp, 4*1        ;eliberam de pe stiva
        
        push dword a        ;punem pe stiva adresa lui a 
        push dword format   ;punem formatul (intreg cu semn)
        call [scanf]        ;citim a 
        add esp, 4*2        ;eliberam stiva 
        
        ;citim b 
        push dword message2 ;punem pe stiva mesajul
        call [printf]       ; afis: b=
        add esp, 4*1        ;eliberam de pe stiva
        
        push dword b        
        push dword format   ;punem formatul (intreg cu semn)
        call [scanf]        ;citim b 
        add esp, 4*2        ;eliberam de pe stiva
        
        ;afis a 
        push dword [a]      
        push dword format
        call [printf]       ; afisam val lui a 
        add esp, 4*2        ;eliberam de pe stiva
        
        ;salvam a in eax si b in ebx
        mov eax,[a]
        mov ebx,[b]
        
        ;comparare a cu b 
        cmp eax,ebx         ; comparam eax=[a] cu ebx=[b] 
        jl mai_mic
        je egale
        jg mai_mare
        
        
    mai_mic:   
        push dword mic
        call [printf]   ;afis <
        add esp, 4*1
        jmp final
        
    egale:
        push dword egal
        call [printf]   ;afis =
        add esp, 4*1
        jmp final
    
    mai_mare:
        push dword mare
        call [printf]   ;afis >
        add esp, 4*1
        
    final:
        push dword [b]       
        push dword format
        call [printf]       ;afisam val lui b 
        add esp, 4*2        ;eliberam de pe stiva
        
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
