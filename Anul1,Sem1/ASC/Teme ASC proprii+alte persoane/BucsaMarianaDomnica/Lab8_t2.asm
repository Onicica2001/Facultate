bits 32 

global  start 

extern  exit, printf, fopen, fclose, fread
import  exit msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll


segment  data use32 class=data 
    k dd 0
    nu_speciale db "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",0
    format db "Nr de caractere speciale este %d",0
    nume_f db "fisier.txt",0
    mod_acces db "r",0
    descriptor_f dd -1
    len equ 100
    text times len db 0
     
     

;5. Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de caractere speciale si sa se ;afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.
segment  code use32 class=code 
start: 
     ; deschidem fisierul eax=fopen(nume_f, mod_acces)
     push dword mod_acces
     push dword nume_f
     call [fopen]
     add esp, 4*2
     mov [descriptor_f], eax
     cmp eax, 0
     je final
     
     ; citim continutul fisierului eax=fread(text, 1, len, descriptor_f)
     push dword [descriptor_f]
     push dword len
     push dword 1
     push dword text
     call[fread]
     add esp, 4*4
     
     ; parcurgem text si numaram caracterele speciale
     mov ecx, eax
     jecxz inchidere_fisier
     cld 
     mov esi, text
     pt_text:
     lodsb 
     push ecx
     push esi
     mov bl, al
     mov esi,nu_speciale
     mov ecx, 52
     jecxz final
     pt_nu_speciale:
     lodsb
     cmp bl,al
     je nu_e_special
     loop pt_nu_speciale
     
     add dword [k],1
     
     nu_e_special:
     pop esi
     pop ecx
     
     loop pt_text
     
     ; afisam nr de caractere speciale
     push dword [k]
     push dword format
     call [printf]
     
     ; inchidem fisierul
     inchidere_fisier:
     push dword [descriptor_f]
     call [fclose]
     add esp,4
     
     final:
     push dword 0 
     call [exit] 