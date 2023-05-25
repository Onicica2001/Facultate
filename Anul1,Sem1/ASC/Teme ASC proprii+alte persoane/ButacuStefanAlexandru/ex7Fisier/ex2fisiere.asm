bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external fun
extern exit, fopen, fclose, fread, fprintf 
extern printf            
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll
                      

; Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine litera mica (lowercase) cu cea mai mare frecventa si sa se afiseze acea litera, impreuna cu frecventa acesteia. Numele fisierului text este definit in segmentul de date.
segment data use32 class=data
    nume_fisier db "text.txt", 0 
    mod_acces db "r", 0 
    descriptor_fis dd -1 
    len equ 100
    text times len+1 db -1
    alfabet db 'abcdefghijklmnopqrstuvwxyz'
    len_alf equ $-alfabet
    len_text dd 0 
    max_fr dd 0 
    max_ch db 0
    format_afis db "Litera %c,  are frecventa maxima %d", 0 
    scrie_fisier db "raspuns.txt" , 0
    mod_scrie db "w", 0 
    handler_scrie dd -1
    ; our code starts here
segment code use32 class=code
    start:
        ; eax = fopen(char* nume fisier, char * mod acces)
        push dword mod_acces
        push dword nume_fisier
        call [fopen] 
        add esp, 4*2                 ;eliberez parametrii  
        mov [descriptor_fis], eax    ; salvez valoarea returnata in variabila descriptor_fis
                                    ; verific daca fopen a deschis cu succes 
        cmp eax, 0 
        je final 
        
        ; citesc textul din fisierul deschis cu fread 
        ; int fread(void * str, int size, int count, FILE * stream)
        ; eax = fread(text, size , count, descriptor_fis)
        push dword [descriptor_fis]
        push dword len  ; numarul maxim de elemente citite din fisier 
        push dword 1 
        push dword text 
        call [fread] 
        add esp ,4*4 
        mov [len_text], eax ; in len_text am lungimea textului din fisier 
        ;;;;;;; inchid fisierul 
        push dword [descriptor_fis]
        call [fclose] 
        add esp , 4 
        ;;;;;;;;;;;;;;;;;;;
        mov esi, 0
        mov ecx, len_alf            ; iau fiecare litera din alfabet si vad de cate ori se repeta in text  
        cmp ecx,0 
        je final
        repeta:
        mov ebx, 0 ; frecventa literei  
        mov al, [alfabet+esi]                        ; in al am litera din aflabet 
                                              ; trebuie sa parcurc stringul text si sa numar de cate ori al == text[i] 
       
        push ecx ; salvez ecx un pentru loop repeta 
        
        mov ecx, [len_text]  
     
        mov edi, 0 
        cmp ecx, 0 
        je final 
    vezi_text:
        mov dl, [text+edi] ; dl = text[i] 
        cmp al, dl 
        je sunt_egale
        jmp skip
    sunt_egale:
        inc ebx 
    skip:     
        inc edi ; i++ 
    loop vezi_text  ; dec ecx
        cmp ebx,[max_fr] 
        ja new_max  
        jmp skip2
    new_max:
        ; EBX > max_fr 
        mov [max_fr], ebx 
        mov [max_ch], al 
    skip2:    
        pop ecx; readuc ecx, ul pentru a parcurge literele din alfabet 
        inc esi
    loop repeta 
    
        ; afisez litera si frecventa 
        ; int printf(const char * format, variabila_1, constanta_2, ...);
        ; printf(format, chr , fr ) 
        ; AFISARE PE ECRAN
        mov eax,  [max_fr]
        mov ebx, 0 
        mov bl, [max_ch]  
        push eax   
        push ebx 
        push dword format_afis
        call [printf] 
        add esp, 4*3 
        
        ; PENTRU SCRIERE IN FISIER 
                                    ; DESCHID FISIERUL
        ; fopen(char* nume fisier, char * mod acces)
        push dword mod_scrie
        push dword scrie_fisier
        call [fopen] 
        add esp, 4*2 
        cmp eax, 0 
        je final
        mov [handler_scrie] , eax 

                                        ; SCRIU IN FISIER   
       ; ; int fprintf(FILE * stream, const char * format, <variabila_1>, <constanta_2>, <...>)
        mov eax, [max_fr]
        mov ebx,0 
        mov bl, [max_ch] 
        push eax 
        push ebx 
        push dword format_afis
        push dword [handler_scrie]
        call [fprintf] 
        add esp, 4*4 
        ; ; 
                            ; INCHID FISIERUL 
        push dword [handler_scrie]
        call [fclose] 
        add esp , 4 
    final: 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
