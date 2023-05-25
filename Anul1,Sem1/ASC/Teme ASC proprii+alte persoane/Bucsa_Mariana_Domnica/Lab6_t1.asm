bits 32 

global  start 

extern  exit 
import  exit msvcrt.dll

; Se da un sir S de dublucuvinte.
segment  data use32 class=data 
     s dd 12345607h, 1A2B3C15h, 13A33412h
     len_s equ ($-s)/4
     sapte db 7
     d times len_s-1/4 db 0
     
     

; Sa se obtina sirul D format din octetii inferiori ai cuvintelor inferioare din elementele sirului de dublucuvinte, care sunt 
; multiplii de 7.
segment  code use32 class=code 
start: 
     mov ecx, len_s
     jecxz final
       
      cld
      mov esi, s
      mov edi, d
      
     repeta:
     lodsb               ;-> AL = 07h  inc(ESi) 
     mov bl,al           ;-> BL = 07h
     lodsb
     lodsw
     mov al,bl
     mov ah,0
     div byte [sapte]    ;-> AL= AX/7 AH=AX%7
     
     cmp ah,0
     jnz nu_e_multiplu
     
     mov al, bl
     stosb
     
     
    nu_e_multiplu: 
     loop repeta
     final:
     push dword 0 
     call [exit] 
