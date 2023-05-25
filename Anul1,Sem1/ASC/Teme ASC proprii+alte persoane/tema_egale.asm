bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
        s1 db "abbgiilzz"
        l1 equ $-s1
        s2 db "abbbccddghhvvxy"
        l2 equ $-s2
        s3 times l1+l2 db 0 

; 16. Se dau doua siruri de caractere ordonate alfabetic s1 si s2. Sa se construiasca prin interclasare sirul ordonat s3 care sa contina toate elementele din s1 si s2.
segment code use32 class=code
    start:
        
        mov ecx , 0 ; vom retine in ecx cate elemente am luat din s1
        mov edx , 0 ; vom retine in edx cate elemente am luat din s2
        mov esi , s1 ; ESI = offset sir sursa s1  
        mov edi , s3 ; EDI = offset sir destinatie s3
        
        cld ; directia de parcurgere va fi de la stanga spre dreapta deoarece sirurile sunt ordonate crescator
        
        repeta_interclasare: ; folosim un loop cu un numar necounoscut de pasi
        
            cmp ecx , l1
            je exit_loop ; se efectueaza iesirea din interclasare daca am ajuns cu parcurgerea la finalul primului sir s1 
            
            cmp edx , l2
            je exit_loop ; se efectueaza iesirea din interclasare daca am ajuns cu parcurgerea la finalul celui de-al doilea  sir s2
        
            lodsb  
            mov bl , [s2+edx] ; AL = valoarea de la offsetul curent din s1 + inc ESI si BL = valoarea de la adresa s2+edx 
            
            cmp al , bl
            jle lesser ; se compara lexicografic cele doua caractere extrase - nu am putut folosi CMPSB deoarece ESI si EDI sunt deja incarcati
            
            mov al , bl ; mutam valoarea mai mica lexicografic in registrul AL pentru a folosi stosb
            stosb ; se adauga in s3 , la offsetul curent , valoarea registrului al in urma compararii + inc EDI
            inc edx 
            dec esi ; are loc decrementarea registrului ESI deoarece s-a preluat o valoare din sirul s2 , iar valoarea curenta din s1 trebuie comparata cu viitoarele elemente din s2
            jmp repeta_interclasare
            
            lesser:
                stosb ; se adauga in s3 , la offsetul curent , valoarea registrului al in urma compararii + inc EDI 
                inc ecx  
                jmp repeta_interclasare
       
       exit_loop:
       
       cmp edx , l2 ; 
       je parcurgere_sir1 ; decidem in care sir au mai ramas elemente de adaugat
       
       parcurgere_sir2: ; se parcurg elementele ramase in s2
       
       cmp edx , l2
       je end_program ; in cazul in care am luat din s2 toate elementele ramase,iesim din block-ul de cod curent direct la exit
       
       mov al , [s2+edx] ; se adauga in AL valoarea urmatoare din sirul s2
       stosb ; se adauga in s3 , la offsetul urmator , valoarea din AL
       inc edx 
       jmp parcurgere_sir2 ; loop cu nr necounoscut de pasi
       
       parcurgere_sir1:  ; se parcurg elementele ramase in s1
       
       cmp ecx , l1 
       je end_program ; in cazul in care am luat din s1 toate elementele ramase,iesim din block-ul de cod curent direct la exit
       
       mov al , [s1+ecx] ; se adauga in AL valoarea urmatoare din sirul s1
       stosb ; se adauga in s3 , la offsetul urmator , valoarea din AL
       inc ecx 
       jmp parcurgere_sir1   ; loop cu nr necounoscut de pasi  
       
       end_program:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
