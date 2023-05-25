bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b-word; c,d-byte; e-doubleword; x-qword - Interpretare cu semn
segment data use32 class=data
    a dw 10
    b dw 1
    c db 36
    d db 5
    e dd 100
    x dq 30

; 1/a+200*b-c/(d+1)+x/a-e
segment code use32 class=code
    start:
        ;1/a
        mov ax, 1
        cwd                   ;DX:AX=1
        idiv word [a]         ;AX=1/a
        
        cwd                   ;DX:AX=1/a
        
        ;200*b
        mov bx, 200
        imul word [b]         ;CX:BX=200*b
        
        add bx, ax            
        adc cx, dx            ;CX:BX=1/a+200*b
        
        ;c/(d+1)
        mov dl, [d]
        add dl, 1             ;DL=d+1
        
        mov al, [c]
        cbw                   ;AX=c
        
        idiv dl               ;AL=c/(d+1)     
        
        ;1/a+200*b-c/(d+1)
        cbw
        cwd                   ;DX:AX=c/(d+1) 
        
        sub bx, ax
        sbb cx, dx            ;CX:BX=1/a+200*b-c/(d+1) 
        
        push cx
        push bx 
        pop ebx               ;EBX=1/a+200*b-c/(d+1)          
        
        ;x/a
        mov ax, a
        cwde                  ;EAX=a 
        mov ecx, eax          ;ECX=a
        
        mov eax, [x]
        cdq                   ;EDX:EAX=x
       
        idiv ecx              ;EAX=x/a    ,EDX=x%a  

        ;1/a+200*b-c/(d+1)+x/a-e        
        add ebx, eax          ;EBX=1/a+200*b-c/(d+1)+x/a
        
        sub ebx, [e]          ;EBX=1/a+200*b-c/(d+1)+x/a-e    
        
        
        
        
        
        
        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
