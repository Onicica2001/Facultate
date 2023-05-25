bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern fopen , fclose , fread , printf 
extern exit               
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll               
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    consoane db "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
    len_consoane equ $-consoane
    nume_fisier db "input.txt" , 0
    mod_acces db "r" , 0 
    descriptor dd 0 
    len equ 100 
    citite resb len 
    caract_citite dd 0 
    copie_ecx dd 0 
    rezultat dd 0 
    mesaj_rezultat dd "Numarul consoanelor din sirul citit este: %d" , 0 

; 2. Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de consoane si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.
segment code use32 class=code
    start:
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp , 4*2 ; se deschide fisierul "input.txt" din directorul proiectului pentru a se realiza citirea caracterelor
        
        cmp eax , 0 ; se compara descriptorul de fisier cu 0 si daca sunt egale se sare la final-fisierul nu a fost deschis cu succes
        je final_desinvalid
        
        mov [descriptor] , eax ; se salveaza descriptorul fisierului daca este valid intr-o variabila pentru a putea citi 
        xor edx , edx  ; in edx o sa salvam rezultatul final al problemei - nr de consoane 
        
        citire:
        
        add [rezultat] , edx ; se adauga la rezultat nr consonelor din loop-ul anterior
        xor edx , edx 
        
        push dword [descriptor]
        push dword len 
        push dword 1 
        push dword citite 
        call [fread]
        add esp , 4*4 ; se realizeaza citirea primelor 100 de caractere din fisier si se salveaza in sirul "citite"
        
        cmp eax , 0 
        je final_citire ; cum in eax se salveaza nr de caractere citite , o sa iesim din loop cand valoarea acestuia este 0 - adica am citit toate caracterele
        
        mov [caract_citite] , eax ; se salveaza numarul caracterelor citite in dword-ul caract_citite
        mov esi , citite ; se realizeaza o parcurgere caracter cu caracter a sirului citit 
        
        mov ecx , [caract_citite] ; se pregateste primul loop 
        
        parcurgere_citite:
        
        lodsb ; se ia urmatorul caracter din sirul citit 
        mov [copie_ecx] , ecx ; se salveaza valoarea lui ecx pentru primul loop
        
        mov ecx , 0 
        
            parcurgere: ; loop cu nr necunoscut de pasi care verifica daca caracterul actual din sir este o consoana 
                mov bl , [consoane+ecx] ; se ia urmatorul caracter din "consoane" daca mai exista 
                cmp al , bl ; se compara caracterul din sirul curent cu urmatoarea consoana 
                je consoana_valid ; se sare afara din parcurgere daca am gasit egalitate 
                
                inc ecx ; se continua cu parcurgerea sirului de consoane 
                cmp ecx , len_consoane ; se compara contorul curent cu lungimea sirului consoane 
                ja consoana_invalid ; daca ecx > len_consoane inseamna ca,caracterul curent nu este consoana 
                jbe parcurgere ; se continua parcurgerea daca inca nu am parcurs tot sirul de consoane 
        
        consoana_valid:
            inc edx ; se incrementeaza edx daca am gasit o consoana 
           
        consoana_invalid:
            mov ecx , [copie_ecx] ; se revine la valoarea lui ecx de dinaintea loop-ului parcurgere
            
        loop parcurgere_citite
     
        jmp citire ; se continua citirea din fisier  
        
        final_citire: ; eticheta unde se sare daca nu mai sunt caractere de citit 
        push dword [descriptor]
        call [fclose]
        add esp , 4 ; se inchide fisierul cu ajutorul descriptorului daca am citit toate caracterele
        
        final_desinvalid:
        
        push dword [rezultat]
        push dword mesaj_rezultat
        call [printf]
        add esp , 4*2 ; se afiseaza rezultatul problemei in consola - numarul consoanelor din sirul citit 
     
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
