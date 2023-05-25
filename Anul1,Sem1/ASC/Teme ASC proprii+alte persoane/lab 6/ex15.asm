bits 32 

global start        

extern exit              
import exit msvcrt.dll    

;Se da un sir S de dublucuvinte
segment data use32 class=data
   s DD 12345607h, 1A2B3C15h
   l equ $-s
   d times l db 0
   ;d DB 56h, 3Ch, 34h, 2Bh, 1Ah, 15h, 12h, 07h

;15.Sa se obtina sirul D format din octetii dublucuvintelor din sirul D sortati in ordine descrescatoare in interpretarea fara semn
segment code use32 class=code
    start:
        mov ecx,l
        jecxz Final
        cld
        mov esi,s
        mov edi,d
        Rep movsb  
        mov ecx,l
        dec ecx
        mov esi,0    
        Repetam:
          mov edi,esi
          inc edi
          Repetam2:  
          mov al,[d+esi]
          mov dl,[d+edi]
          cmp al,dl
          jae Continuam
          mov [d+esi],dl
          mov [d+edi],al 
          Continuam:
          inc edi
          cmp edi,l
          jne Repetam2
          inc esi
          loop Repetam
          
        Final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program