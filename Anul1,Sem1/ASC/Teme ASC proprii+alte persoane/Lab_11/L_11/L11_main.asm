bits 32 


global start        


extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

extern dublate
                          


segment data use32 class=data
    nume_fisier db "numere.txt", 0  
    mod_acces db "r", 0           
    len dd 0       
    buffer db 0
    nr_curent dd 0
    text times 100 dd 0   
    descriptor_fis dd -1
    format db "textul e: ",0
    format_nr db "%d ", 0
    format_endl db 10
    D times 100 dd 0

    
; 20. Se citeste din fisierul numere.txt un sir de numere. Sa se determine sirul destinatie D care contine numerele din sirul initial cu valorile ;dublate dar in ordine inversa din sirul initial. Sa se afiseze sirul obtinut pe ecran.
;Ex: s: 12, 2, 4, 5, 0, 7 => 14, 0, 10, 8, 4, 24
segment code use32 class=code
    start:
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je .final
        
        ; citim textul in fisierul deschis folosind functia fread
        ; eax = fread(text, 1, len, descriptor_fis)
        mov esi, 0
        .citire:
            push dword [descriptor_fis]
            push dword 1
            push dword 1
            push dword buffer    
            call [fread]
            add esp, 4*4
            cmp eax, 0
            jz .iesire_citire
            cmp byte[buffer], ' '
            jne .aici
            mov dword[nr_curent], 0
            inc dword[len]
            add esi, 4
            .aici:
            cmp byte[buffer], ' '
            je .continua
            mov eax, dword[nr_curent]
            mov ebx, 10
            mul ebx
            mov ebx, 0
            mov bl, byte[buffer]
            sub bl, '0'
            add eax, ebx
            mov dword[nr_curent], eax
            
            mov dword[text+esi], eax
            .continua:
            jmp .citire
        
        .iesire_citire:
        cmp byte[buffer], 0
        jz .not_inc
        inc dword[len]
        .not_inc:
        
        ;inchidem fisierul
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
        ;afis text initial
        mov ecx, dword[len]
        jecxz .final1
        push dword text
        push dword format
        call [printf]
        add esp, 4*2
        
        mov esi, text
        mov ecx, dword[len]
        .afis_init:
            lodsd
            pushad
            push eax
            push dword format_nr
            call [printf]
            add esp, 4*2
            popad
        loop .afis_init
        push dword format_endl
        call [printf]
        add esp, 4
        
        .final1:
        
        push text
        push D
        push len
        call dublate
        ; ;dublare sir
        ; mov ecx, dword[len]
        ; jecxz .final
        ; lea esi, [text+ecx*4-4]
        ; mov edi, 0
        ; .repeta:
            ; mov eax, dword[esi]
            ; mov ebx, 2
            ; mul ebx
            ; ;edx:eax =nr*2
            ; mov [D+edi*4],eax
            ; inc edi
            ; sub esi, 4
        ; loop .repeta
        
        ;afis text dupa dublare
        mov ecx, dword[len]
        jecxz .final
        push dword text
        push dword format
        call [printf]
        add esp, 4*2
        
        mov esi, D
        mov ecx, dword[len]
        .afis_dub:
            lodsd
            pushad
            push eax
            push dword format_nr
            call [printf]
            add esp, 4*2
            popad
        loop .afis_dub
        
    .final:
        push    dword 0      
        call    [exit]       
