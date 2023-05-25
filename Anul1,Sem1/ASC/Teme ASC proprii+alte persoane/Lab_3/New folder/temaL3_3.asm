bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
; a-byte; b-doubleword; c-qword INTERPRETAREA FARA SEMN
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
        mul al     ; AX = a*a
    
        ; a*a-b
        mov dx, 0  ; conversia AX -> DX:AX
        
        sub ax, word[b]
        sbb dx, word[b+2] ; DX:AX = a*a-b
        
        ; (a*a-b+7)
        mov bl,7
        mov bh,0   ;  conversia BL -> BX
        mov cx,0    ; conversia BX -> CX:BX
        
        add ax,bx
        add dx,cx   ; DX:AX=(a*a-b+7)
        
        ;2+a
        mov bl,2
        add bl,[a] ; BL = a+2
        
        mov bh,0   ; BX = a+2
        
        ;(a*a-b+7)/(2+a)
        div bx     ; AX <- DX:AX / BX  , DX <- DX:AX % BX
        
        push dx
        push ax
        pop eax   ; EAX = (a*a-b+7)/(2+a)
        
        mov edx,0 ; conversie EAX -> EDX:EAX        
        
        ; c+(a*a-b+7)/(2+a)
        
        add eax,dword[c]
        adc edx,dword[c+4]   ;  EDX:EAX = c+(a*a-b+7)/(2+a)
        
  
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
