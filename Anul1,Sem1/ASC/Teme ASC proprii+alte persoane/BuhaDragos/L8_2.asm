bits 32 ; assembling for the 32 bits architecture


global start        


extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
 


segment data use32 class=data
    nume_fisier db "lab8.txt", 0  
    mod_acces db "r", 0           
    len equ 100                                             
    text times (len+1) db 0      
    descriptor_fis dd -1         
    format2 db "Cifra cu cea mai mare frecventa e: %d si apare de: %d ori", 0  
    fr times 10 db 0                ; retine frecventa cifrelo
    cifre times len db 0       ; retine toate cifrele din fisier    
    cifm dd 0                   ; cifra cu ceaa mai mare frecventa
    frm dd 0                    ;frecventa cea mai mare
    len_cifre db 0

    
;6. Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine cifra cu cea mai mare frecventa si sa se afiseze acea cifra impreuna cu ;    frecventa acesteia. Numele fisierului text este definit in segmentul de date.
segment code use32 class=code
    start:
       
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je final
        
        ; citim textul in fisierul deschis folosind functia fread
        ; eax = fread(text, 1, len, descriptor_fis)
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4                 ; dupa apelul functiei fread EAX contine numarul de caractere citite din fisier
        
        
        
        ; Luam cifrele
        mov ecx, len
        mov esi, text
        mov edi, cifre
        cifre_repeta:
            lodsb
            cmp AL, '0'
            JB skip
            cmp AL, '9'
            JA skip
            sub AL, '0' ; Convertim din ASCII in nr
            stosb
            inc byte[len_cifre] ; Sa stim cate cifre sunt
            skip:
        loop cifre_repeta

        ; Contorizarea in "vectorul de frecventa"
        mov ecx, [len_cifre]
        mov esi, cifre
        frecventa_repeta:
            mov EAX, 0
            lodsb
            inc byte[fr+EAX]
        loop frecventa_repeta

        ; cautarea in "vectorul de frecventa"
        mov ecx, 9
        mov esi, 0
        mov al,0
        mov bl,0
        mov al,byte[fr+esi]
        mov [cifm],bl
        mov [frm],al
    repeta:
        inc esi
        mov bl,byte[fr+esi]
        cmp al,bl
        jb mic
        ja sari
        
        
        mic:
        mov al, bl
        mov [cifm], esi
        mov [frm], al
        
        sari:
        loop repeta
        
        
        
        push dword [frm]
        push dword [cifm]
        push dword format2
        call [printf]
        add esp, 4*3
     
        
        ; apelam functia fclose pentru a inchide fisierul
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
    final:
        ; exit(0)
        push    dword 0      
        call    [exit]       
