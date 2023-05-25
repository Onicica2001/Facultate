bits 32 
                      
; declare the EntryPoi
global start          
                      
; declare external fun
extern exit, printf, scanf           
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

extern e_prim             
                      
; Se citeste de la tastatura un sir de numere in baza 10. Sa se afiseze numerele prime.
segment data use32 class=data
    mesaj_input db "N=", 0 
    format db "%d", 0 
    format2 db "%d ,", 0 
    text db "Dati cele %d numere unul cate unul ", 0 
    text_afis db "Numerele prime sunt: ", 0
    N dd 0
    x dd 0 
    sir times 100 dd -1 
; our code starts here
segment code use32 class=code
     start:
        push dword mesaj_input
        call [printf]
        add esp, 4 
        ; scanf(format, N)
        push N  
        push dword format
        call [scanf]
        add esp, 4*2
        ; printf(text, N)
        push dword [N] 
        push dword text
        call [printf]
        add esp, 4*2
        ; citim numerele din sir 
        mov ecx, [N] 
        jecxz skip
        mov esi, 0 
  repeta:
        pushad               ; salvez registrii 
        push x               ; citesc elementul din sir 
        push dword format
        call [scanf]
        add esp, 4*2
        popad               ; readuc registrii 
        mov eax, [x]
        mov dword [sir + esi], eax  
        add esi, 4 
   loop repeta
        pushad
        push dword text_afis
        call [printf]
        add esp, 4
        popad
            
        ; parcurc sirul elemet cu element si apelez functia e_prim pt fiecare element 
        
        mov esi, sir 
        cld
        mov ecx, [N]
        jecxz skip
  parcurge:
        lodsd  ; eax = sir + esi  
               ; e_prim(EAX) 
        mov ebx, eax 
        ; apel e_prim(eax)
        push eax
        call e_prim
        ; eax = e_prim(eax) 
        cmp eax, 1
        je este_prim
        jmp sari
        
     este_prim:
        pushad
        push ebx
        push format2
        call [printf]
        add esp,  4*2    
        popad
    sari:
 loop parcurge 
    skip: 

        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
