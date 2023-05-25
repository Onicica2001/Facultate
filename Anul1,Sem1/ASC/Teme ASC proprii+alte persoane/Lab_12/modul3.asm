bits 32 ; assembling for the 32 bits architecture

extern _CSubsir 
extern _citireSirC
extern _scanf 
extern _printf 


global _run



; our data is declared here (the variables needed by our program)
segment data public data use32
    adresaSir1 dd 0 
    formatsir db "%s", 0 
    formatint db "%d", 0 
    textNr db " Dati numarul de siruri pe care le veti introduce ", 0 
    N dd 0 
    textSir2 db "Dati sirul IN care se va cauta " , 0
    sir2 times 100 resb 0 
    
;Se citesc mai multe siruri de caractere. Sa se determine daca primul apare ca subsecventa in fiecare din celelalte si sa se dea un mesaj corespunzator.
; our code starts here
segment code public code use32
    ; inst _run( char sir1[]) 
_run:
    
    push ebp
    mov ebp, esp 
    
   ; sub esp, 4 * 10 ;???
    ;-------------------------------------------------------
    mov eax, [ebp + 8] ; aici se afla adresaSir1
   
    mov [adresaSir1], eax ; aici crapa  
    
    ; printf("%s", textNr)
    push dword textNr 
    call _printf
    add esp, 4*1 
    
    push dword N
    push formatint
    call _scanf
    add esp, 4*2 
    
  ;  push dword [N] 
  ;  push formatint
  ;  call _printf
    
    ;---------------???
    mov ecx, [N] 
    repeta:
    
    pushad 
    
    push dword textSir2
    call _printf
    add esp,4 
    
    push sir2 
    push formatsir
    call _scanf
    add esp, 4 * 2 
    
    push sir2 
    push dword [adresaSir1]
    call _CSubsir ; eax = _CSubsir(adresaSir1, sir2)   ;  crapa atunci cand sir1 nu se gaseste ca subsecventa in sir2  
    add esp, 4 * 2                                      ; chiar daca bucata in c rezolva 
    
    cmp eax, 0 
    je nu_e_sub
    popad
        
loop repeta
      
   ; daca s-a ajuns aici inseamna ca a fost subsecventa in toate
    mov esp, ebp
    pop ebp
    mov eax, 1 
    ret 
    nu_e_sub:
    mov esp, ebp
    pop ebp
    mov eax, 0 
    ret 
    
    
 