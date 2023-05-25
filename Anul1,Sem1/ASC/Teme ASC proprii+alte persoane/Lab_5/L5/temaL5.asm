bits 32
global start        


extern exit               
import exit msvcrt.dll   
   
segment data use32 class=data
   s db '+', '4', '2', 'a', '@', '3', '$', '*'
   ls equ $ - s  ; lungimea sirului s
  
   c db '!', '@', '#', '$', '%', '^', '&', '*'
   lc equ $ - c   ; lungimea sirului c
  
   d times ls db 0
     
segment code use32 class=code
    start:
         
    mov ecx, ls ;punem lungimea in ECX pentru a putea realiza bucla loop de ecx ori
    mov edx,0    
    mov esi, 0
    cld
	jecxz Sfarsit 
    
    Sirul_s:
           
       mov al ,[s+esi]
       mov edi,0
       inc esi
       
       Sirul_c:
         mov bl, [c+edi]
         inc edi
         
         cmp al,bl
         je egale
         
         cmp edi,ls
         jbe Sirul_c   ; nu merge pt ca pt acest loop se ia din ecx ...merge la infinit
       
    cmp esi,ls
    jbe Sirul_s
    
    egale:
          mov [d+edx],al 
          inc edx
    cmp esi,ls
    jbe Sirul_s
    
    Sfarsit:    
             
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
