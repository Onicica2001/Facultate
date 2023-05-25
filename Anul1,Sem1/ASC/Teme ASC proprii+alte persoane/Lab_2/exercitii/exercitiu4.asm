; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
;a,b,c - byte, d - word
;d+10*a-b*c
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
      a db 2
      b db 5
      c db 3
      d dw 6

; our code starts here
segment code use32 class=code
    start:
        ;
        ;d
        mov ax,[d] ; AX=d
        
        push DX    ; DX:AH
        push AX    ; DX:AX
        pop EBX    ; EBX=DX:AX=d
        
        ;d+10*a
        mov AX,10  ; AX=10
        mov DX,[a] ; DX=a
        mul DX     ; DX=DX:AX=10*a
        
        push DX    ;DX:AX
        push AX    ;DX=AX
        pop EAX    ;EAX=DX:AX=10*a
        
        add EBX,EAX;EBX=EBX+EAX=d+10*a
        
        ;d+10*a-b*c
        
        mov AX,[b] ;AX=b        
        mov DX,[c] ;DX=c
        mul DX     ;DX=DX:AX=b*c
        
        push DX    ;DX:AX
        push AX    ;DX:AX
        pop EAX    ;EAX=b*c
        
        sub EBX,EAX;EBX=EBX-EAX=d+10*a-b*c
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
