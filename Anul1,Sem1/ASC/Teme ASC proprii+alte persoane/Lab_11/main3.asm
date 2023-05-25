bits 32 
global start        
extern exit,scanf,printf        
import exit msvcrt.dll    
import scanf msvcrt.dll 
import printf msvcrt.dll 
extern Miau,s2
segment data use32 class=data
    mesaj db "Introduceti sirul : ",0
    mesaj1 db "Sirul format doar din litere mari este : ",0
    mesaj2 db 0xA, 0xD,"Sirul format doar din litere mici este : ",0
    format db "%s",0
    s times 50 db 0
    s1 resb 50
;Se citeste de la tastatura un sir de caractere (litere mici si litere mari, cifre, caractere speciale, etc). Sa se formeze un sir nou doar cu literele mici si un sir nou doar cu literele mari. Sa se afiseze cele 2 siruri rezultate pe ecran.
segment code use32 class=code
    start:
        push dword mesaj
        call [printf]
        add esp,4
        
        push dword s
        push dword format
        call [scanf]
        add esp,4*2
        
        mov esi,s
        mov edi,s1
        mov ecx,0
        cld
        call Miau
     
        push dword mesaj1
        call [printf]
        add esp,4
        
        push dword s1
        push dword format
        call [printf]
        add esp,4*2
        
        push dword mesaj2
        call [printf]
        add esp,4
        
        push dword s2
        push dword format
        call [printf]
        add esp,4*2  
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
