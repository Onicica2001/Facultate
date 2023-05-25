bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b-byte; c-word; e-doubleword; x-qword
segment data use32 class=data
    a db 0FFh
    b db 11h 
    c dw 21h
    e dd 0FFFFFh
    x dq 112233h
    
; (a-2)/(b+c)+a*c+e-x (ex. 7)
segment code use32 class=code
    start:
        ; calculez b + c 
        mov AL, [b] 
        CBW ; AX  = b 
        mov BX, [c] ;  BX = c 
        add BX, AX ; BX = BX + AX = b + c 
        
        ; calculez a - 2 
        mov AL, [a] 
        sub AL, 2  
        
        CBW ; AL -> AX 
        CWD ; AX -> DX:AX = a - 2
        
        idiv BX   ; DX:AX / BX = cat AX rest DX     
        mov BX, AX ; BX  = (a-2)/(b+c)
        
        ; calculez a * c 
        mov AL, [a] 
        CBW ; AL -> AX = a 
        imul word [c]  ; DX:AX = a * c 
        
        ; calculez (a-2)/(b+c) + a * c 
        push DX
        push AX
        pop EBX  ; EBX = a * c
        
        mov AX, BX 
        CWDE ; ; EAX = (a - 2) / ( b + c )
        
        add EBX, EAX ; EBX = EBX + EAX =  a * c + (a - 2) / ( b + c )
        
        ;calculez (a-2)/(b+c) + a * c + e 
        mov EAX , [e]
        add EAX, EBX;  ; EAX = EAX + EBX = (a-2)/(b+c) + a * c + e 
                       ; daca am CF dupa aceasta adunare?
        CDQ   ; EAX -> EDX:EAX 
        
        mov EBX, [x]
        mov ECX, [x+4] 
        ;ECX : EBX = x 
        ;calculez (a-2)/(b+c)+a*c+e-x
        ; EDX: EAX - 
        ; ECX: EBX 
        sub EAX, EBX
        sbb EDX, EBX 
        ;rezultatul este in EDX: EAX 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        .