bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions



; Se da un sir de octeti S
segment data use32 class=data
    S db 1,2,3,4,5,6,7,8
    len equ $-S
    D times len db 0
    ; D: 1, 3, 5, 7, 2, 4, 6, 8
; Sa se construiasca sirul D astfel: sa se puna mai intai elementele de pe pozitiile pare din S iar apoi elementele de pe pozitiile impare din S
segment code use32 class=code
    start:
    
         mov esi,0   ; i=0
         mov edi,0   ; j=0
         
         ;Vrem sa vedem daca S are un numar par de elemente sau un numar impar
         mov ax,len
         mov dx,0 ; DX:AX=len
         mov bx,2 
         div bx  ;DX:AX/BX= AX, DX:AX%BX =DX
         cmp dx,0
         jz LenPar
         mov ecx,len/2+1
         jmp Incepem
         
         LenPar:
         mov ecx,len/2
         
         Incepem:
         jecxz Final
         mov al,[S+esi]
         mov [D+edi],al
         add esi,2
         inc edi
         loop Incepem
         
         mov ecx,len/2
         mov esi,1
         
         Incepem2:
         mov al,[S+esi]
         mov [D+edi],al
         inc edi
         add esi,2
         loop Incepem2

         Final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
