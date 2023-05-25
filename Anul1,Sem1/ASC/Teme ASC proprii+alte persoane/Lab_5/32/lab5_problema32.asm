bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    S DB 1,6,3,1
    l equ $-S         ;scadem din pozitia curenta din memorie pozitia lui S pentru a afla cati octetii am alocat 
    D times (l-1) db 0;rezervam l-1 octeti pentru rezultat
;Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1 astfel incat elementele din D sa reprezinte catul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S
; our code starts here
segment code use32 class=code
    start:
        
        mov ecx, l-1         
;stabilim cati pasi vom face = (l-1)
        mov esi, 0           
;vom folosi esi ca si contor pentru a sti la ce element ne aflam 
        jecxz Sfarsit        
;daca ecx = 0 se opreste
        start_loop:          
;inceputul loop ului
            mov al, [S+esi]  
;copiem elementul de pe pozitia esi din S
            mov bl, [S+esi+1]
;copiem elementul de pe pozitia esi+1 din S
            mov ah, 0        
;golim ah de valori reziduale pentru a face impartirea
            div bl           
;impartim elementul de pe pozitia esi din S la cel de pe pozitia esi + 1
            mov [D+esi], al  
;adaugam rezultatul in sirul de rezultate
            inc esi          
 ;crestem esi pentru a trece la urmatorul element din S      
            loop start_loop
        Sfarsit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
