bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b-word; c,d-byte; e-doubleword; x-qword - Interpretare fara semn
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
        mov dx, 0          ;DX:AX=1
        div word [a]       ;AX=1/a si DX=1%a
        
        ;200*b
        mov bx, 200       
        mul word [b]      ;CX:BX=200*b
        
        ;1/a+200*b
        add ax, bx
        adc dx, cx         ;DX:AX=1/a+200*b
        
        ;c/(d+1)
        mov cl, [d]        
        add cl, 1          ;CL=d+1
        
        mov bl, [c]
        mov bh, 0          ;BX=c
        div cl             ;BL=c/(d+1) si BH=c%(d+1)
        
        ;1/a+200*b-c/(d+1)
        mov bh, 0          ;BX=c/(d+1)
        mov cx, 0          ;CX:BX=c/(d+1)
        
        sub ax, bx
        sbb dx, cx         ;DX:AX=1/a+200*b-c/(d+1)
        
        push dx
        push ax
        pop edx            ;EDX=1/a+200*b-c/(d+1)
        
        ;x/a
        mov ax, [a]        ;AX=a
        mov dx, 0          ;DX:AX=a
        
        push dx
        push ax
        pop eax            ;EAX=a
        
        mov ebx, [x]
        mov ecx, 0         ;ECX:EBX=x
        
        div eax            ;EBX=ECX:EBX/EAX= x/a si ECX=ECX:EBX%EAX= x%a
        
        
        
        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
