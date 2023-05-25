bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a - dword , b - dword , c - qword 
segment data use32 class=data
    a dd 10010011111111001100010011110110b
    b dd 10111111010101010001010110000000b
    c resq 1 
    
; 29.
; bitii 0-7 ai lui C sunt bitii 21-28 ai lui A
; bitii 8-15 ai lui C sunt bitii 23-30 ai lui B complementati
; bitii 16-21 ai lui C sunt 101010
; bitii 22-31 ai lui C au valoarea 0
; bitii 32-42(0-10) ai lui C sunt bitii 21-31 ai lui B
; bitii 43-55(11-23) ai lui C sunt bitii 1-13 ai lui A
; bitii 56-63(24-31) ai lui C sunt bitii 24-31 ai rezultatului A XOR 0ABh
segment code use32 class=code
    start:
        
        mov ebx , 0 ; vom calcula bitii 0-31 a lui c in ebx 
        
        
        ; bitii 0-7 ai lui C sunt bitii 21-28 ai lui A
        mov eax , dword [a] ; izolam bitii 21-28 a lui a 
        and eax , 00011111111000000000000000000000b
        ror eax , 21 ; rotim bitii 21 de pozitii spre dreapta eax = 00000000000000000000000011111111b
        or ebx , eax ; punem bitii in rezultat
        
        xor eax , eax; eax = 0 
        
        ; bitii 8-15 ai lui C sunt bitii 23-30 ai lui B complementati
        mov eax , dword[b] 
        not eax ; inversam valorile bitilor din eax 
        and eax , 01111111100000000000000000000000b ; izolam bitii 23-30 a lui b 
        ror eax , 15 ; rotim bitii 15 pozitii spre dreapta eax = 00000000000000001111111100000000b
        or ebx , eax ;punem bitii in rezultat
        
        xor eax , eax ; eax = 0
        
        ; bitii 16-21 ai lui C sunt 101010
        or ebx , 00000000001010100000000000000000b ; mutam pe pozitiile 16-21 in ebx bitii 101010
        
        ; bitii 22-31 ai lui C au valoarea 0
        and ebx , 00000000001111111111111111111111b ; facem bitii 21-31 in ebx sa fie 0 
        
        ;in acest moment, in ebx avem partea mai putin semnificativa a qword-ului c 
        
        mov ecx , 0 ; vom calcula bitii 32-63 a lui c in ecx 
        
        ; bitii 32-42 ai lui C sunt bitii 21-31 ai lui B
        mov edx , dword [b]
        and edx , 11111111111000000000000000000000b ; izolam bitii 21-31 a lui b 
        ror edx , 21 ; rotim bitii lui ecx 21 de pozitii spre dreapta ecx = 00000000000000000000011111111111b
        or ecx , edx ; punem bitii in rezultat 
         
        xor edx , edx ; zerorizam edx
        
        ; bitii 43-55(11-23) ai lui C sunt bitii 1-13 ai lui A
        mov edx , dword [a]
        and edx , 00000000000000000011111111111110b ; izolam bitii 1-13 a lui a 
        rol edx , 10 ; rotim 10 pozitii bitii aflati in edx 
        or ecx , edx ; punem bitii in rezultat 
        
        xor edx , edx ; zerorizam edx 
        
        ; bitii 56-63(24-31) ai lui C sunt bitii 24-31 ai rezultatului A XOR 0ABh
        
        mov edx , dword [a]
        mov eax , 0ABh 
        xor edx , eax ; se realizeaza operatia xor intre edx(a) si eax(0ABh) si rezultatul se stocheaza in edx 
        
        and edx , 11111111000000000000000000000000b ; izolam bitii 24-31 a rezultatului din edx 
        or ecx , edx ; punem bitii in rezultat deoarece se aflau deja pe pozitiile bune in edx 
        
        ;in acest moment, in ecx avem partea mai semnificativa a qword-ului c
        
        mov [c+0] , ebx 
        mov [c+4] , ecx 
        ; c - rezultatul problemei(am copiat la adresele respective cele doua parti care compun qword-ul c)
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
