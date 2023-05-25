bits 32 

global start        

extern exit, fopen, fread, fprintf, fclose, printf, scanf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll  
import fprintf msvcrt.dll  
import fclose msvcrt.dll  
import printf msvcrt.dll  
import scanf msvcrt.dll  

;Sa se citeasca de la tastatura un nume de fisier si un text.
; Sa se creeze un fisier cu numele dat in directorul curent si
; sa se scrie textul in acel fisier. Observatii: Numele de
; fisier este de maxim 30 de caractere. Textul este de
; maxim 120 de caractere.
segment data use32 class=data
    nume_fisier resb 30
    text resb 120
    mesaj_fisier db "Introduceti numele fisierului: ", 0
    mesaj_text db "Introduceti textul: ", 0
    mod_acces db "w", 0
    descriptor dd -1
    format db "%s", 0
    

segment code use32 class=code
    start:
    
        ; intial, citim numele fisierului
        ; printf(mesaj_fisier)
        push dword mesaj_fisier
        call [printf]
        add esp, 4
        ; scanf(format, nume_fisier)
        push dword nume_fisier
        push dword format
        call [scanf]   ;  am citit numele fisierului
        add esp, 4*2
        
        ; acum, citim textul
        ; print(mesaj_text)
        push dword mesaj_text
        call [printf]
        add esp, 4
        ; scanf(format, text)
        push dword text
        push dword format
        call [scanf]
        add esp, 4*2
        
        ; Deschidem fisierul cu numele nume_fisier
        ; fopen(nume_fisier, mod_acces)
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor], eax
        cmp eax, 0
        je final
        
        ; fprintf(descriptor, text)
        push dword text
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2
        
        ; inchidem fisierul
        ; fclose(descriptor)
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        
        final:
        push    dword 0     
        call    [exit]       
