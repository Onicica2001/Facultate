bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
segment data use32 class=data
     a db 40
     b dw 20
     c dd 10
     d dq 30
  
; (b+c+d)-(a+a)
segment code use32 class=code
    start:
        ; (b+c+d)
        mov ax, [b]
        cwd             ;DX:AX=b
        mov bx, [c]
        mov cx, [c+2]
        add ax, bx
        adc dx, cx      ;DX:AX=b+c
        
        push dx
        push ax
        pop eax         ;EAX=b+c
        cdq             ;EDX:EAX=b+c
        
        mov ebx, [d]
        mov ecx, [d+4] ;ECX:EBX=d
        
        add eax, ebx
        adc edx, ecx    ;EDX:EAX=b+c+d
        
        mov ebx, eax
        mov ecx, edx    ;ECX:EBX=b+c+d
        
        ;(a+a)
        mov al, [a]     ;AL=a
        add al, [a]     ;AL=a+a
        cbw             ;AX=a+a
        cwde            ;EAX=a+a
        cdq             ;EDX:EAX=a+a
        
        ;(b+c+d)-(a+a)
        sub ebx, eax    
        sbb ecx, edx    ;ECX:EBX=(b+c+d)-(a+a)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
