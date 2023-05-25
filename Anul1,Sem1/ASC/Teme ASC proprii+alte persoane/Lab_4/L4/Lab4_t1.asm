bits 32 

global  start 

extern  exit 
import  exit msvcrt.dll

; R,T,Q- doubleword
segment  data use32 class=data 
     R dd 11110000111100001111000011110000b
     T dd 10101010101010101010101010101010b
     Q dd 0
;26.Sa se obtina dublucuvantul Q astfel:
;bitii 0-6 din Q coincid cu bitii 10-16 a lui T.
;bitii 7-24 din Q concid cu bitii obtinuti 7-24 in urma aplicarii R XOR T.
;bitii 25-31 din Q coincid cu bitii 5-11 a lui R.
segment  code use32 class=code 
start: 

     mov ebx, 0 ; in registrul ebx vom calcula rezultatul
      
     ;bitii 0-6 din Q coincid cu bitii 10-16 a lui T.
     mov eax, [T] 
     and eax, 00000000000000011111110000000000b
     ror eax, 10 
     or  ebx, eax 
     
     ;bitii 7-24 din Q concid cu bitii obtinuti 7-24 in urma aplicarii R XOR T.
     mov eax, [R] 
     mov edx, [T]
     xor eax, edx
     and eax, 00000001111111111111111110000000b
     or ebx, eax

     ;bitii 25-31 din Q coincid cu bitii 5-11 a lui R.
     mov eax, [R]
     mov edx, 00000000000000000000111111100000b
     and eax, edx
     rol eax, 20
     or ebx, eax

     mov  [Q], ebx 

     push dword 0 
     call [exit] 
