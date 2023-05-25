bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b-byte; c-word; e-doubleword; x-qword 
segment data use32 class=data
    a db 0EEh
    b db 11h 
    c dw 21h
    e dd 0FFFFFh
    x dq 112233h
    
; interpretare fara semn 
; (a-2)/(b+c)+a*c+e-x; ex 7 
segment code use32 class=code
    start:
        ; calculez a - 2 
        mov AL, [a]
        mov AH, 0
        sub AX, 2    ; AX = a - 2 
       
        ; calculez b + c 
        mov BL, [b] 
        mov BH, 0   ; BX = b 
        add BX, [c] ; BX = BX + c = b + c 
        
        ; calculez (a-2)/ (b + c) 
        mov DX, 0 
        div BX   ; DX:AX / BX = cat AX   restul DX 
        
        mov BX, AX ; pastrez rezultatul temporar in BX = (a-2) / (b + c )
        
        mov AX, 0
        mov AL, [a] ; AX  = a 
        mul word [c]  ; DX:AX = AX*c = a * c 
        push DX
        push AX
        pop EDX ; EDX = a * c 
        
        mov EAX, 0 
        mov AX, BX ; EAX = AX = BX = (a - 2 ) / ( b + c) 
        
        add EAX, EDX ; EAX = EAX + EDX = (a-2)/(b+c) + a * c 
        
        mov EBX, [e] ; EBX = e 
        add EAX, EBX ; EAX = EAX + EBX = (a-2)/(b+c) + a * c + e ; +CF 
        mov EBX, 0
        adc EBX, 0 ; EBX = 0 + CF
        ; EBX : EAX = (a-2)/(b+c) + a * c + e
        
        
        ; calculez (a-2)/(b+c)+a*c+e-x 
        mov ECX, [x]
        mov EDX, [x+4] 
        ;    EBX : EAX -  
        ;x = EDX : ECX 
        ;     
        sub EAX, ECX ; EAX = EAX - ECX ; scad partile low 
        sbb EBX, EDX ; EAX = EAX - ECX - CF 
        ; rezultatul este in EBX:EAX 

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
