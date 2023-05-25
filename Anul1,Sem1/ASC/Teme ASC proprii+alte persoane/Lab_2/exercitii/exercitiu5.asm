;Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
;a,b,c,d-byte
; e,f,g,h-word
;(e+g-h)/3+b*c
bits 32 ; assembling for the 32 bits architecture


; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
     ;
     b db 2
     c db 3
     e dw 4
     g dw 8
     h dw 6

; our code starts here
segment code use32 class=code
    start:
        ;(e+g-h)/3
        mov AX,[e]; AX=e
        add AX,[g]; AX=AX+g=AX=e+g
        sub AX,[h]; AX=AX-h=e+g-h
        mov BL, 3 ; BL=3
        div BL    ; AX=AX/BL=(e+g-h)/3
        
        push DX   ; DX:AX
        push AX   ; DX:AX
        pop EBX   ; EBX=AX=(e+g-h)/3
        
        ;b*c
        mov DX,[c]; DX=c
        mov AX,[b]; AX=b
        mul DX    ; DX=DX*AX
        
        push DX    ;DX:AX
        push AX    ;DX:AX
        pop EAX    ;EAX=b*c
        
        ;(e+g-h)/3+b*c
        add EBX,EAX; EBX=EBX+EAX
        
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
