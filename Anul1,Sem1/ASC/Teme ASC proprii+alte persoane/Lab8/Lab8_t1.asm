bits 32 

global  start 

extern  exit, printf, scanf 
import  exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll


segment  data use32 class=data 
    a dd 0
    b dd 0
    k dd 2
    mesaj1 db "a= ",0
    mesaj2 db "b= ",0
    afisare db "(a-b)*2= %X %X h",0
    format db "%d",0
     
     

; 26. Se citesc de la tastatura doua numere a si b. Sa se calculeze valoarea expresiei (a-b)*k, k fiind o constanta definita in ; segmentul de date. Afisati valoarea expresiei (in baza 16).
segment  code use32 class=code 
start: 
     ; citim a
     push dword mesaj1
     call [printf]
     add esp,4
     push dword a
     push dword format
     call [scanf]
     add esp,8
     
     ; citim b
     push dword mesaj2
     call [printf]
     add esp,4
     push dword b
     push dword format
     call [scanf]
     add esp,4*2
     
     ; (a-b)*k
     mov eax, [a]
     sub eax, [b]
     imul dword [k]
      
     ; afisare q-word
     push eax
     push edx
     push dword afisare
     call [printf]
     add esp, 4*3
     
     push dword 0 
     call [exit] 
