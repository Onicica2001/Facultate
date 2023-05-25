bits 32 

global  start 

extern  exit 
import  exit msvcrt.dll

; S1, S2, D - siruri de caractere
segment  data use32 class=data 
     S1 db '+', '2', '2', 'b', '8', '6', 'X', '8'
     len_S1 equ $-S1
     S2 db 'a', '4', '5'
     len_S2 equ $-S2
     D times len_S1+len_S1 db 0
     
     
; 10. Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor sirului S2 in ordine inversa cu elementele de pe pozitiile pare din sirul S1.
segment  code use32 class=code 
start: 
     mov ecx,len_S2
     jecxz final
     mov esi,0              ; i=0 pentru sirul S1
     mov edi,len_S2     
     dec edi                ; j=len_S2-1 pentru sirul S2
     mov ebx,0              ; k=0 pentru sirul D
     
     repeta1:
        mov al,[S2+edi]
        mov [D+ebx],al
        inc ebx
        dec edi
     loop repeta1
     
     mov ecx,len_S1
     jecxz final
     
     repeta2:
        mov eax,esi
        inc eax
        test eax,01h        ; pozitiile sirului sa inceapa de la 1
        jz par              
        
        inc esi
        jmp peste
        
     par:
        mov al,[S1+esi]
        mov[D+ebx],al
        inc ebx
        inc esi
     peste:
        loop repeta2
     
     final:
     push dword 0 
     call [exit] 
