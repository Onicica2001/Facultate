bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; s1 - sir octeti , s2 - sir octeti , d - sir octeti 
segment data use32 class=data
    s1 db -15 , 2 , -33 , 10 , -2 , 67 , -100 , 49 , 88 , 22 
    l equ $-s1 
    s2 db 4 , 5 , -10 , 6 , -8 , 19 , 90 , 15 , -29 , 0 
    d times l db 0 
    a resd 1 

; 4 . Se dau doua siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel: fiecare element de pe pozitiile pare din D este suma elementelor de pe pozitiile corespunzatoare din S1 si S2, iar fiecare element de pe pozitiile impare are ca si valoare diferenta elementelor de pe pozitiile corespunzatoare din S1 si S2.
segment code use32 class=code
    start:
        
        mov ecx , l ; punem lungimea celor doua siruri in ecx pentru a realiza bucla loop de l ori 
        mov esi , 0 ; indexare pozitie de inceput 
        jecxz Sfarsit ; programul trece la exit daca lungimea sirurilor este nula
        
        Repeta:
                mov [a] , esi 
                mov ax , word [a]
                mov dx , word [a+2]
                ;dx:ax = a = esi ; indexul unde am ajuns cu parcurgerea 
                mov bx , 2 
                div bx ; se realizeaza impartirea indexului la care am ajuns si 2 pentru a determina natura pasului in care ne aflam
                ; dx = a%2
                
                cmp dx , 1 ; se compara restul impartirii indexului la 2 pentru a afla paritatea pasului 
                je Impar ; se sare la Eticheta1 in cazul in care restul este 1(ne aflam la index impar)
                
                mov al , [s1+esi]
                mov bl , [s2+esi]
                ; se copiaza in cei doi registri al si bl , valorile din s1 si s2 corespunzatoare indexului curent
                add al , bl 
                mov [d+esi] , al ; se copiaza in noul sir format , valoarea calculata pe pozitia indexului curent
                inc esi ; incrementare index curent 
                loop Repeta
                
                Impar: ; parte de cod corespunzatoare cazului cand indexul la care am ajuns este impar
                    mov al , [s1+esi]  
                    mov bl , [s2+esi]
                    ;se copiaza in cei doi registri al si bl , valorile din s1 si s2 corespunzatoare indexului curent
                    sub al , bl 
                    mov [d+esi] , al ; se copiaza in noul sir format , valoarea calculata pe pozitia indexului curent
                    inc esi ; incrementare index curent 
                    loop Repeta               
        
        Sfarsit:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
