bits 32

global start       

extern exit, scanf, printf, fopen, fprintf, fclose             
import exit msvcrt.dll    
import scanf msvcrt.dll    
import printf msvcrt.dll    
import fopen msvcrt.dll    
import fprintf msvcrt.dll    
import fclose msvcrt.dll  

extern maxim
  
;25. Se citeste de la tastatura un sir de numere in baza 10, cu semn. Sa se determine valoarea maxima din sir si sa se afiseze in fisierul max.txt (fisierul va fi creat) valoarea maxima, in baza 16.
segment data use32 class=data
    nume_fisier db "max.txt", 0
    mod_acces db "w", 0
    n dd 0
    nr dd 0
    mem dd 0
    sir times 50 dd 0
    desc_fis dd 0
    mesaj dd "Lungimea: ", 0
    format_citire dd "%d"
    format_afisare dd "%x"

segment code use32 class=code
    start:
        push dword mesaj
        call [printf]
        add esp, 4*1
        
        ; citim nr de elemente pe care o sa il aiba sirul
        push dword n
        push dword format_citire
        call [scanf]
        add esp, 4*2
        
        mov ecx, [n]
        
        jecxz final
        
        mov edi, sir
        repeta:
        
            mov [mem], ecx
            ; citim cate un numar de la tastatura
            push dword nr
            push dword format_citire
            call [scanf]
            add esp, 4*2
            
            mov eax, [nr]
            
            stosd ; adaugam numarul in sir
            
            mov ecx, [mem]
            
        loop repeta
        
        push dword [n]
        push dword sir
        call maxim
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [desc_fis], eax ; salvam valoarea returnata de fopen in desc_fis
        
        push dword ebx
        push dword format_afisare
        push dword [desc_fis]
        call [fprintf]
        add esp, 4*3
        
        final:
            ; inchidem fisierul
            push dword [desc_fis]
            call [fclose]
            add esp, 4*1
        
        push    dword 0      
        call    [exit]   
