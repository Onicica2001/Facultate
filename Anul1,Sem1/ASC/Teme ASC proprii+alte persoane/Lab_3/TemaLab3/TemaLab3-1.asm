bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a - byte, b - word, d - qword - Interpretare fara semn
segment data use32 class=data
    a db 40
    b dw 30
    d dq 10

; 1.8.(a+b-d)+(a-b-d) 
segment code use32 class=code
    start:
        ;(a+b-d)
        mov al, [a]
        mov ah, 0         ;AX=a conversie fara semn de la ah la ax
        add ax, [b]  ;AX=a+b 
        
        mov dx, 0         ;DX:AX=a+b conversie fara semn de la ax la dx:ax             
        
        push dx 
        push ax
        pop eax           ;eax=a+b
        
        mov edx, 0        ;edx:eax=a+b 
        sub eax, [d]
        sbb edx, [d+4]  ;edx:eax=a+b-d  
        
        ;(a-b-d)
        mov bl, [a]
        mov bh, 0        ;BX
        sub bx, [b]
        
        mov cx, 0
        
        push cx
        push bx
        pop ebx
        
        mov ecx, 0
        sub ebx, [d]
        sbb ecx, [d+4]
        
        ;(a+b-d)+(a-b-d) 
        add eax, ebx
        adc edx, ecx
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
