;a,b,c - byte, d - word 
;d-[3*(a+b+2)-5*(c+2)] 
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
    a db 5
    b db 6
    c db 7
    d dw 256
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al, [a] ; AL = a
        add al, [b] ; AL = AL + b = a + b 
        add al, 2   ; AL = AL + 2 = a + b + 2
        
        mov cl, 3   ; CL = 3
        mul cl      ; AX = AL * CL = (a + b + 2) * 3 
        
        mov cl, 0   ; CL = 0        
        mov cl, [c] ; CL = c 
        add cl, 2 ; CL = CL + 2 
        
        mov dx, ax ; DX = AX = (a + b + 2 ) * 3 
        
        mov al, cl ; AL = CL = (c + 2) 
        mov bl, 5 ; bl = 5
        mul bl ; AX = AL * BL = (c + 2 ) * 5 
        sub dx, ax  ; DX = DX - AX = (a + b + 2) * 3 - 5 * (c + 2)
        
        mov bx, [d] ; BX = d
        sub bx,dx 
       
        
    
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
