bits 32 


global start        


extern exit, printf, scanf               
import exit msvcrt.dll    
import printf msvcrt.dll     ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll      ; similar pentru scanf

                        

;Se citesc de la tastatura numere (in baza 10) pana cand se introduce cifra 0. 
;Determinaţi şi afişaţi cel mai mic număr dintre cele citite.
segment data use32 class=data

    n dd 0
    message  db "Cel mai mic numar citit este %d", 0  
	format  db "%d", 0  ; %d <=> un numar decimal (baza 10)
    
segment code use32 class=code
    start:
        push  dword n       
        push  dword format
        call  [scanf]       
        add  esp, 4 * 2 
        
        mov eax , [n]
        
        
        repeta:
        
        PUSHAD   ; folosim instructiunea PUSHAD care salveaza pe stiva valorile mai multor registrii, printre care EAX, ECX, EDX si EBX 
         
        ; vom apela scanf(format, n) => se va citi un numar in variabila n
        ; punem parametrii pe stiva de la dreapta la stanga
        push  dword n       ; ! adresa lui n, nu valoarea
        push  dword format
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2     ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
        POPAD
        
        mov edx,[n]
        
        cmp edx,0
        jz sari
        
        cmp eax,edx
        jb sari    ; daca eax < edx
        
        ; verific care e cel mai mic
        mov eax,edx
        
        
        sari:
        ; verifi daca n este 0
        cmp edx,0
        jnz repeta
        
        
        ; afisez cel mai mic numar
        push dword eax
        push dword message 
        call [printf]      
        add esp, 4*2       
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
