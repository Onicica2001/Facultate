bits 32 


global start 
      

extern exit, printf, fopen,fread, fclose               
import exit msvcrt.dll  
import printf msvcrt.dll 
import fopen msvcrt.dll
import fread msvcrt.dll 
import fclose msvcrt.dll
 
extern modul



segment data use32 class=data
    i dd 0
    j dd 0
    k db 10
    nume_f db "numere.txt",0
    mod_acces db "r",0
    descriptor_f dd -1
    len equ 100
    buffer times len db 0
    N times len dd 0 
    P times len dd 0

;19.Se citesc din fisierul numere.txt mai multe numere (pozitive si negative). Sa se creeze 2 siruri rezultat N si P astfel: N - doar numere negative si P - doar numere pozitive. Afisati cele 2 siruri rezultate pe ecran.

segment code use32 class=code
    start:
     ; deschidem fisierul eax=fopen(nume_f, mod_acces)
     push dword mod_acces
     push dword nume_f
     call [fopen]
     add esp, 4*2
     mov [descriptor_f], eax
     cmp eax, 0
     je final
     
     ; citim continutul fisierului eax=fread(buffer, 1, len, descriptor_f)
     push dword [descriptor_f]
     push dword len
     push dword 1
     push dword buffer
     call[fread]
     add esp, 4*4
     
     mov ebx,0
     mov ecx, eax
     mov esi, buffer
     numere:
     ; luam pe rand fiecare caracter si formam numere
        lodsb
        cmp al,' '
        je positive_or_negative
        cmp al,'-'
        jne char_to_integer
          lodsb
          sub ecx,1
          sub al, '0'
          neg al
          jmp peste
        
        char_to_integer:
            sub al,'0'
            peste:
            cbw
            cwde
            mov edx,eax
            mov eax,ebx
            imul byte [k]
            mov ebx,eax
            add ebx,edx
        
        back:
        loop numere
        
      ; stocam numerele in sirul corespunzator 
      
      positive_or_negative:
            mov eax,ebx
            mov ebx,0
            sub eax,0
            jns adauga_pozitive
            mov edi, N
            add edi, [j]
            stosd
            add dword[j],4
            cmp ecx,0
            jne back
            adauga_pozitive:
                mov edi, P
                add edi, [i]
                stosd
                add dword[i],4
            cmp ecx,0
            jne back
       
    ; afisare
       push dword[i]
       push P
       push dword [j]
       push N
       call modul
      
    final:
        push dword [descriptor_f]
        call [fclose]
        add esp,4
        push    dword 0      
        call    [exit]       
