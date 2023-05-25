bits 32 


global start        


extern exit, printf, scanf, gets                
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll
extern cod 
;29. Se citeste o propozitie de la tastatura. Sa se numere literele din fiecare cuvant si sa se afiseze aceste numere pe ecran.
segment data use32 class=data
    prop dd 0     ;aici vom stoca propozitia citita de la tastatura
    len equ $-prop
    mesaj_1 db 'Introduceti propozitia: ',0
    format_1 db '%s',0


segment code use32 class=code
    start:
        push dword 6
        call cod 
        
    Final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
