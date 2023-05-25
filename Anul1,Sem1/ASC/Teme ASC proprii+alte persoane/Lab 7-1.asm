bits 32 
global start        
extern exit,scanf,printf         
import exit msvcrt.dll    
import scanf msvcrt.dll 
import printf msvcrt.dll 

segment data use32 class=data
      n dd 0
      format db '%d',0
      mesaj db 'Introduceti numarul : ',0
      mesajfinal db 'Numarul in baza 16 este:' ,0
      format2 db '%x' ,0
      s db 0
;17 Sa se citeasca de la tastatura un numar in baza 10 si sa se afiseze valoarea acelui numar in baza 16
segment code use32 class=code
    start:
        push dword mesaj
        call [printf]
        add esp,4*1
        
        push dword n
        push dword format
        call [scanf]
        add esp,4*2
        
        cmp dword [n],0
        je Final

        mov esi,0
        Incepem:
           mov eax,0
           mov ax, word[n]
           mov dx, word[n+2]  ;DX:AX=n
           
           mov BX,16
           div BX   ;        AX=DX:AX / BX    DX=DX:AX % BX
        
           inc esi
           push dx
           mov [n],eax
           cmp dword [n],0
           jne Incepem
           
           
           mov ecx,esi   
           jecxz Final
           pushad  
           push dword mesajfinal
           call [printf]
           add esp,4*1
           popad
           
           Lala:
           mov edx,0
           pop dx
           pushad
           push edx
           push dword format2
           call [printf]
           add esp, 4*2
           popad
           loop Lala
 
        Final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program