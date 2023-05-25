bits 32 

global start        

extern exit, scanf, printf, fopen, fprintf, fclose        
import exit msvcrt.dll 
import scanf msvcrt.dll 
import printf msvcrt.dll
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll  

; 11. Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura cuvinte si sa se scrie in fisier cuvintele citite pana cand se citeste de la tastatura caracterul '$'.
segment data use32 class=data
    nume_fisier db "fisier.txt", 0
    mod_acces db "w", 0 ; pentru a se modifica fisierul la fiecare apel, sau "a" pentru a se scire in continuare la fiecare apel
    mesaj db "Introduceti cuvintele: ", 0
    text dd 0
    format db "%c"
    desc_fis dd 0

segment code use32 class=code
    start:
        ; apelam functia fopen pentru a crea fisierul
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [desc_fis], eax ; salvam valoarea returnata de fopen in desc_fis
        
        push dword mesaj
        call [printf]
        add esp, 4*1
        
        repeta:
            ; citim cate un cuvant
            push dword text
            push dword format
            call [scanf]
            add esp, 4*2
            
            ; verificam daca s-a citit '$', in caz pozitiv, iesim din repeta
            cmp dword [text], '$'
            je sfarsit
            
            ; daca este diferit de '$' atunci se adauga in fisier
            push dword text
            push dword [desc_fis]
            call [fprintf]
            add esp, 4*2
            
        jmp repeta ; ne intoarcem la inceputul lui repeta pentru a citi urmatorul cuvant
    
        sfarsit:
            ; inchidem fisierul
            push dword [desc_fis]
            call [fclose]
            add esp, 4*1
         
        push    dword 0     
        call    [exit] 