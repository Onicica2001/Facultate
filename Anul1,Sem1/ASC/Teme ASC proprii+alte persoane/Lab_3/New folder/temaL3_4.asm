bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
; a-byte; b-doubleword; c-qword INTERPRETAREA CU SEMN
segment data use32 class=data
    a db 20
    b dd 40
    c dq 80
   
; c+(a*a-b+7)/(2+a)
; our code starts here
segment code use32 class=code
    start:
        ; a*a
        mov al,[a]
        imul al     ; AX = a*a
    
        ; a*a-b
        cwd ; conversia AX -> DX:AX
        
        sbb ax, word[b]
        sbb dx, word[b+2] ; DX:AX = a*a-b
        
        ; (a*a-b+7)
        mov bl,7
        cbw         ;  conversia BL -> BX
        cwd    ; conversia BX -> CX:BX
        
        adc ax,bx
        adc dx,cx   ; DX:AX=(a*a-b+7)
        
        ;2+a
        mov bl,2
        adc bl,[a] ; BL = a+2
        
        mov bh,0   ; BX = a+2
        
        ;(a*a-b+7)/(2+a)
        idiv bx     ; AX <- DX:AX / BX  , DX <- DX:AX % BX
        
        push dx
        push ax
        pop eax   ; EAX = (a*a-b+7)/(2+a)
        
        mov edx,0 ; conversie EAX -> EDX:EAX        
        
        ; c+(a*a-b+7)/(2+a)
        
        adc eax,dword[c]
        adc edx,dword[c+4]   ;  EDX:EAX = c+(a*a-b+7)/(2+a)
        
  
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
