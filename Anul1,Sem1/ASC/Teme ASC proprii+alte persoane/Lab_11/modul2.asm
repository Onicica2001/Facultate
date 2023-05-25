bits 32 
global start        
extern exit,scanf,printf             
import exit msvcrt.dll    
import scanf msvcrt.dll 
import printf msvcrt.dll 
global Miau,s2
segment data use32 class=data
    s2 resb 50
;Se citeste de la tastatura un sir de caractere (litere mici si litere mari, cifre, caractere speciale, etc). Sa se formeze un sir nou doar cu literele mici si un sir nou doar cu literele mari. Sa se afiseze cele 2 siruri rezultate pe ecran.
segment code use32 class=code   
        Miau:
            lodsb
            LiteraMare:
              cmp al,'A'
              jb LiteraMica
              cmp al,'Z'
              ja LiteraMica
              stosb
              jmp NoWay
                LiteraMica:
                  cmp al,'a'
                  jb NoWay
                  cmp al,'z'
                  ja NoWay
                  mov [s2+ecx],al
                  inc ecx
                  NoWay:
                        lodsb
                        cmp al,0
                        jnz LiteraMare
                        ret
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
