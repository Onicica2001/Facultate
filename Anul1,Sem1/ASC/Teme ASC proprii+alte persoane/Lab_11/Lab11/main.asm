bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit           ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern afisare                              

; 22. Se da un numar in baza 2 reprezentat pe 32 de biti. Sa se afiseze reprezentarea in baza 16. (se foloseste conversia rapida)
segment data use32 class=data
    n dd 00010110b

; our code starts here
segment code use32 class=code
    start:
        mov eax, [n]
        call afisare 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
