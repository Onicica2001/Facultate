bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;a - byte, b - word, c - double word, d - qword - Interpretare cu semn
segment data use32 class=data
    a db 15
    b dw 11h
    c dd 1234h
    d dq 0AAAAh
;  ; (c+c+c)-b+(d-a) (ex 7)
segment code use32 class=code
    start:
        ; calculez c + c + c 
        mov EAX, [c] ; EAX = c 
        add EAX, [c] ; EAX = EAX + c = c + c 
        CDQ  ; EDX: EAX 
        adc EDX, 0 ; EDX = CF
        add EAX, [c] ; EAX = c + c + c 
        adc EDX, 0 ; adun CF daca exista
        ; EDX:EAX = c + c + c
        mov EBX, EAX  
        mov ECX, EDX 
        ;ECX:EBX = c + c + c
        
        ; calculez (c+c+c)-b
        ; trebuie sa convertesc wordul b la un dw 
        mov AX, [b] 
        CWDE ; EAX = b 
        CDQ ; EDX:EAX = b  
        ; c + c + c =ECX : EBX -
        ; b =        EDX : EAX  
            
        sub EBX, EAX  ; scad partile nesemnificative din dw, posibi CF  
        sbb ECX, EDX ; scap de CF 
        ; ECX:EBX = c + c + c - b 
        
        push ECX
        push EBX 
        
        ; calculez d - a 
        mov AL, [a] ; AL  = a
        CBW
        CWDE  
        CDQ
        ; EDX : EAX = a 
        
        mov ECX, [d]    ; ECX = partea nesemnficativa din d 
        mov EBX, [d+4]  ; EBX = partea nesemnficiativa din d - a 
        
       ; d = EBX:ECX - 
       ; a = EDX:EAX 
        
        sub ECX, EAX ; ECX = ECX - EAX  
        sbb EBX, EDX 
        ; EBX :  ECX = d - a 
        
        pop EAX  
        pop EDX  
                ; am luat de pe stiva rezultatul c + c + c  - b 
                ; si l am pus in registrii EDX : EAX 
        ; calculez (c+c+c)-b   +   (d-a) 
        ;           EDX:EAX +  
        ;           EBX:ECX
      
        add EAX, ECX ; 
        adc EDX, EBX 
        
        ; rezultatul este in EDX: EAX 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
