bits 32 


global start        


extern exit,fopen,fclose,printf,fread               
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll    

;Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de cifre impare si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.
segment data use32 class=data
    nume_fisier db "Tema.txt",0
    mod_acces db "r",0
    descriptor_fisier dd -1
    nr_car_citite dd 0
    len equ 100
    buffer resb len
    contor dd 0
    format db "In fisier exista %d cifre impare",0

segment code use32 class=code
    start:
        ;Deschidem fisierul
        
        push dword mod_acces        ;Punem adresa stringului 'mod_acces' pe stiva
        push dword nume_fisier      ;Punem adresa stringului 'nume_fisier' pe stiva
        call[fopen]                 ;Deschidem fisierul cu numele 'nume_fisier' in modul 'mod_acces'
        add esp,4*2                 ;Eliberam parametrii de pe stiva
        
        ;Verificam daca fisierul s-a deschis corect
        
        cmp eax,0                   ;In EAX se salveaza descriptorul fisierului.Compara EAX cu 0
        je final                    ;Daca EAX este 0 inseamna ca fisierul nu s-a deschis corect, iar programul se termina
        
        mov [descriptor_fisier],eax ;Salvam descriptorul fisierului in 'descriptor_fisier'
        
        repeta:
            push dword [descriptor_fisier]  ;Punem valoarea lui 'descriptor_fisier' pe stiva
            push dword len                  ;Punem numarul de elemente care pot fi citite intr-o etapa pe stiva
            push dword 1                    ;Punem dimensiunea unui elemente care poate fi citit pe stiva   
            push dword buffer               ;Punem adresa unui sir de elemente in care se vor completa datele citite din fisier
            call[fread]                     ;Apelam functia fread
            add esp,4*4                     ;Eliberam parametrii de pe stiva
            
            cmp eax,0                       ;Comparam numarul de elemente citite salvat in EAX cu 0
            je cleanup                      ;Daca nu au mai fost citite elemente sarim la cleanup
            
            mov [nr_car_citite],eax         ;Salvam numarul de elemente citite intr-o variabila
            
            ;Contorizarea numarului de cifre impare 
            
            mov ecx,[nr_car_citite]         ;In ECX salvam numarul de elemente citite
            mov esi,buffer                  ;In ESI salvam offsetul sirului de elemente in care s-au completat datele citite din fisier
            numara:
                lodsb                       ;Incarcam in AL byte-ul de la adresa <DS:ESI>
                cmp al,'9'                  ;Comparam AL cu caracterul 9
                ja nu_numar                 ;Daca este mai mare sarim la nu_numar
                cmp al,'0'                  ;Comparam AL cu caracterul 0
                jb nu_numar                 ;Daca este mai mic sarim la nu_numar
                test al,1                   ;Aplicam operatia AND imaginara intre AL si 1
                jz nu_numar                 ;Daca numarul este par atunci ultima cifra va fi 0, iar ZF va fi setat pe 1. Daca ZF este 1 sarim la nu_numar
                add dword [contor],1        ;Crestem contorul
                loop numara         
            
            jmp repeta
        nu_numar:
            dec ecx                         ;Decrementam ECX
            jecxz repeta                    ;Daca ECX este 0 sarim la repeta
            jmp numara
        cleanup:
            push dword [descriptor_fisier]  ;Punem valoarea lui 'descriptor_fisier' pe stiva
            call[fclose]                    ;Apelam functia fclose
            add esp,4                       ;Eliberam parametrii de pe stiva
        push dword [contor]                 ;Punem valoarea contorului 'contor' pe stiva
        push dword format                   ;Punem adresa stringului 'format' pe stiva
        call[printf]                        ;Apelam functia printf
        add esp,4*2                         ;Eliberam parametrii de pe stiva
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
