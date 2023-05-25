;Efectuați calculele și analizați rezultatele:

;13/3


bits 32 
global start        


extern exit               
import exit msvcrt.dll   
segment data use32 class=data
   
segment code use32 class=code
    start:
        mov ax, 13 ;ax = 13
        mov bh,3
        div bh ;al = ax/3 = 13/3 and ah = ax%3 = 13%3
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
