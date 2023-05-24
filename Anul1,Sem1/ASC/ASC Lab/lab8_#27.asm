bits 32 

global start        


extern exit,printf,scanf               
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll    

;Se dă un sir de caractere (definit in segmentul de date). Să se citească de la tastatură un caracter, să se determine numărul de apariţii al acelui caracter în şirul dat şi să se afişeze acel caracter împreună cu numărul de apariţii al acestuia.
segment data use32 class=data
    sir db 'a','b','c','d','a','a'
    len_s equ $-sir
    mesaj db "c=",0
    format_1 db "%c",0
    format_2 db "Caracterul %c apare de %d ori",0
    contor dd 0
    caracter db 0


segment code use32 class=code
    start:
        ;Citim de la tastatura caracterul 'caracter'
        
        push dword mesaj    ;Punem adresa stringului 'mesaj' pe stiva
        call[printf]        ;Apelam functia printf si se afiseaza "c= "
        add esp,4           ;Eliberam parametrii de pe stiva
        
        push dword caracter ;Punem adresa caracterului 'caracter' pe stiva
        push dword format_1 ;Punem adresa stringului 'format_1' pe stiva
        call[scanf]         ;Apelam functia scanf si asteptam introducerea de la tastatura a unui caracter
        add esp,4*2         ;Eliberam parametrii de pe stiva
        
        
        ;Determinam numarul de aparitii al caracterului 'caracter'
        
        mov ecx,len_s           ;ECX ia valoarea lungimii sirului sir
        jecxz final             ;Daca ECX este 0 sarim la final
        mov esi,sir             ;ESI ia valoarea offsetului sirului sir
        repeta:
            lodsb               ;Incarcam in AL byte-ul de la adresa <DS:ESI>
            cmp al,[caracter]   ;Comparam caracterul din AL cu caracterul 'caracter'
            je gasit            ;Daca este acelasi caracter sarim la gasit
            loop repeta         
        jmp final   
        gasit:
            inc dword[contor]   ;contor=contor+1
            dec ecx             ;Decrementam ECX
            jecxz final         ;Daca ECX este 0 sarim la final
            jmp repeta          ;Sarim la repeta
        
        final:
        ;Afisam caracterul 'caracter' si numarul sau de aparitii
        ;printf(const char * format, variabila_1, constanta_2, ...)
        
        push dword [contor]     ;Punem valoarea intregului 'contor' pe stiva
        push dword [caracter]   ;Punem valoarea caracterului 'caracter' pe stiva
        push dword format_2     ;Punem adresa stringului 'format_2' pe stiva
        call[printf]            ;Apelam functia printf si se afiseaza "Caracterul 'caracter' apare de 'contor' ori
        add esp,4*3             ;Eliberam parametrii de pe stiva
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
