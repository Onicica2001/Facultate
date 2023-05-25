bits 32 
global start                 
extern exit, fopen, fclose, fprintf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fprintf msvcrt.dll  
import fclose msvcrt.dll       
segment data use32 class=data
    nume_fisier db "miau.txt", 0 
    text db "KIRA, catelusa mea, este FOARTE obraznica si are doar 4 luni si 25 ziLe.Se joaca TOATA ziua cu URSU si cu pisicile, Misha + Griuta",0
    len equ $-text
    mod_acces db "w", 0        
    descriptor dd -1         

; 14.Se dau un nume de fisier si un text (definite in segmentul de date)
; Textul contine litere mici, litere mari, cifre si caractere speciale
; Sa se transforme toate literele mari din textul dat in litere mici
; Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier
segment code use32 class=code
    start:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp,4*2
        
        mov [descriptor],eax
        
        cmp eax,0
        je Final
        
        mov esi,text
        mov edi,text
        cld
        mov ecx,len-1
        jecxz Final
        
        Incepem:
          lodsb
          cmp al,'A'
          jb NU
          cmp al,'Z'
          ja NU
          add al,32
          NU:
          stosb
          loop Incepem
        
        push dword text
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2
        
        push dword [descriptor]
        call [fclose]
        add esp,4
        Final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
