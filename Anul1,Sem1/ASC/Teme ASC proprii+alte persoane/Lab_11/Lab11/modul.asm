bits 32 

global afisare        

; declare external functions needed by our program
extern printf           
import printf msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    format db "Reprezentarea in baza 16 este: %x", 0

; our code starts here
segment code use32 class=code
    afisare:
        push dword eax 
        push dword format
        call [printf]
        add esp, 4*2
        ret
    

