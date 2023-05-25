;a,b,c,d-byte, e,f,g,h-word
;(f*g-a*b*e)/(h+c*d)


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 3
    b db 5
    c db 2
    d db 3 
    e dw 2
    f dw 10
    g dw 15
    h dw 4
; our code starts here

;a,b,c,d-byte, e,f,g,h-word
;(f*g-a*b*e)/(h+c*d)  150 -30 / ( 4 + 6) = 12 = AX 

segment code use32 class=code
    start:
        ; ...
        ; incep cu formarea numitorului
        
        mov AL, [c]  ;  AL = c 
        mul byte [d] ; AX = c * d 
        mov DX, AX ; DX = AX = c * d  
        add DX , [h] ; DX = DX + h = c * d  + h
        
        mov CX,DX ; CX = DX = c * d + h 
         
         
        mov AX, [f] ; AX = f 
        mul word [g] ; DX:AX = f * g 
        push DX ; se pune pe stiva partea high din double word DX:AX 
        push AX ; ---------------- partea low -------------------------
        pop EBX ; EBX = DX:AX = f * g 
        
        
        mov AL, [a] ; AL = a 
        mul byte [b] ; AX = AL* b = a * b 
        mul word [e] ; DX : AX = AX * e = a * b * e
        
        push DX  ; se pune pe stiva partea high din double word DX:AX 
        push AX  ; ---------------- partea low ------------------------- 
        pop EAX ; EAX  = DX:AX = a * b  * e    
        
        sub EBX, EAX  ; EBX = EBX - EAX = f * g - (a * b * e) 
        
        mov EAX, EBX ; EAX trebuie impartit in DX:AX ca sa se faca impartirea la CX 
                    ; da eroare mov DX:AX, EBX
        
        div word CX 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
