bits 32 
global start 
       
extern exit, fopen, fscanf, fclose, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fscanf msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

extern modul

segment data use32 class=data

        ;Se citesc din fisierul numere.txt mai multe numere (pare si impare). 
        ;Sa se creeze 2 siruri rezultat N si P astfel: N - doar numere impare si P - doar numere pare.
        ;Afisati cele 2 siruri rezultate pe ecran.
        
        nume_fisier db "numere.txt", 0
        mod_acces db "r", 0
        descriptor_fisier dd -1
        len equ 100
        sir times len db 0                      ;sirul
        sir_pare times len db 0                 ;sirul de numere pare
        sir_impare times len db 0               ;;sirul de numere impare
        numar dd 0                              ;numarul elementelor sirului
        numar_pare dd 0                         ;numarul elementelor sirului de numere pare
        numar_impare dd 0                       ;numarul elementelor sirului de numere impare
        n dd 0                         
        format db '%d', 0                       ; formatul de citire din fisier
        mesaj_pare db 'Sirul de numere pare este:', 0
        mesaj_impare db ' iar cel de numere impare este:', 0
        
segment code use32 public code
    start:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor_fisier], eax            ;salvam valoarea returnata de fopen in variabila descriptor_fisier
        
        mov ecx, len
        jecxz stop
        cld
        mov ebx, 0
        mov edi, sir
           
        citire: 
            push dword n
            push dword format
            push dword [descriptor_fisier]
            call [fscanf]
            add esp, 4 * 3                      

            cmp eax, 1
            jne stop
            
            mov eax, [n]
            stosd
            inc ebx
            
        loop citire                                 ; citim pe rand, in variabila n, fiecare numar din fisier
        
        stop:
            mov [numar], ebx                        ; in numar retinem numarul elementelor sirului
            
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4                                  ;inchidem fisierul
        
        mov ecx, [numar]
        mov esi, 0                                  ;i = 0
        mov ebx, 0                                  ;j = 0 (sirul cu numere pare)
        mov edx, 0                                  ;k = 0 (sirul cu numere impare)
        
        repeta:
            mov eax, [sir + esi]
            
            test eax, 01h                           ;testez daca numarul e par sau impar
            jz par
        
            ;numarul e impar
            mov [sir_impare + edx], eax
            add edx, 4
            jmp continua                            ;daca e impar, il adaugam la sirul de numere impare
        
            par:  
                mov [sir_pare + ebx], eax
                add ebx, 4                          ;daca e par, il adaugam la sirul de numere pare
        
            continua:
                add esi, 4
                
        loop repeta
        
        
        mov [numar_pare], ebx
        mov [numar_impare], edx                     ; numarul de elemente din cele doua siruri noi formate
        
        push dword mesaj_pare
        call [printf]
        add esp, 4*1                                ; mesaj pentru afisarea sirului de numare pare
        
        push dword [numar_pare]
        push dword sir_pare
        call modul                                  ; apelam functia modul pentru a afisa numerele pare
       
        push dword mesaj_impare
        call [printf]
        add esp, 4*1                                ; mesaj pentru afisarea sirului de numare impare
        
        push dword [numar_impare]
        push dword sir_impare
        call modul                                  ; apelam functia modul pentru a afisa numerele impare
        
    final:
    
        push    dword 0      
        call    [exit]      
