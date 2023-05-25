bits 32 

global start        

extern exit               
import exit msvcrt.dll    

;  Se dau doua siruri de caractere S1 si 
segment data use32 class=data
    s1 db '+','4','2','a','8','4','X','5'
    l_s1 equ $-s1
    s2 db  'a','4','5'
    l_s2 equ $-s2
    d times l_s1+l_s2 db 0
    ; D   '+', 'a', 'X', '5', '4', 'a'

;28.Sa se construiasca sirul D prin concatenarea elementelor de pe pozitiile multiplu de 3 din sirul S1 cu elementele sirului S2 in ordine inversa
segment code use32 class=code
    start:
         mov ecx, l_s1/3+1
         jecxz Final  ;Jump short if ECX register is 0
         mov esi,0 ; i=0
         mov edi,0 ; y=0
         
         Repeta1:
           mov al, [s1+esi]
           mov [d+edi],al
           add esi, 3
           inc edi 
         loop Repeta1
         
         mov ecx,l_s2
         jecxz Final  ;Jump short if ECX register is 0
         mov esi,l_s2 
         dec esi 
         
         Repeta2:
           mov al, [s2+esi]
           mov [d+edi],al
           inc edi
           dec esi
         loop Repeta2
         
         Final:
          ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
