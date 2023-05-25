bits 32 
global start        

extern exit, fopen, fclose, fprintf              
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data

    ;Se dau un nume de fisier si un text (definite in segmentul de date). 
    ;Textul contine litere mici, litere mari, cifre si caractere speciale. 
    ;Sa se transforme toate literele mici din textul dat in litere mari. 
    ;Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
    
    nume_fisier db "fisier.txt", 0                      ;Numele fisierului         
    mod_acces db "w", 0                                 ;Vom creea si scrie in fisier
    descriptor_fisier dd -1                             ;Prin aceasta variabila vom face referire la fisier
    text db "aNA ArE 5 mERe. aRE EA 4 pRUnE?", 0        ;Textul pe care il introducem in fisier
    lungime_text equ $-text                             ;Lungimea textului
  
segment code use32 class=code
    start:
       
        mov esi, 0                                      ;Retinem al catelea caracter este
        mov ecx, lungime_text
        jecxz scriere_in_fisier
        cld
        
    transformare:
        
        mov al, [text+esi]                              ;AL = caracterul curent
        
        cmp al, 'a'
        jl nu_e_litera_mica                             ;Daca codul ASCII al caracterulul este 
                                                        ;mai mic decat 'a', nu este litera mica 
        
        cmp al, 'z'
        jg nu_e_litera_mica                             ;Daca codul ASCII al caracterulul este 
                                                        ;mai mare decat 'z', nu este litera mica 
        
        ;Este litera mica:
        mov bl, 'a' - 'A'
        sub al, bl
        mov [text+esi], al                              ;Daca caracterul e litera mica, scadem diferenta dintre 'a' si 'A'
        
        nu_e_litera_mica:
        
        inc esi                                         ;Trecem la caracterul urmator
    
    loop transformare 

    scriere_in_fisier:
    
        push dword mod_acces
        push dword nume_fisier
        call [fopen]                                    ;Se creeaza fisierul
        add esp, 4 * 2                                  ;Eliberam elementele de pe stiva
        
        mov [descriptor_fisier], eax                    ;Salvam valoarea in descriptor_fisier
        
        cmp eax, 0
        je final                                        ;Verificam daca s-a creat fisierul
        
        push dword text
        push dword [descriptor_fisier]
        call [fprintf]                                  ;Scriem in fisierul dat textul
        add esp, 4 * 2                                  ;Eliberam elementele de pe stiva
        
        push dword [descriptor_fisier]
        call [fclose]                                   ;Inchidem fisierul
        add esp, 4 * 1                                  ;Eliberam elementele de pe stiva
        
    final:
        
        push    dword 0      
        call    [exit]       
