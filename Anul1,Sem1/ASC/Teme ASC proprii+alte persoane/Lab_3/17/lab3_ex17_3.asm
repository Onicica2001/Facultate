bits 32 
global start        

extern exit      
import exit msvcrt.dll    
segment data use32 class=data
    ; ...
;x-(a*a+b)/(a+c/a); 
;a,c-byte; b-doubleword; x-qword
a db 5
b dw 3
c db 10
x dq 20
; our code starts here
segment code use32 class=code
    start:
        ; ...
    xor eax, eax
    mov al,[a]
    xor edx, edx
    mov dh, [a]
    mul dh
;a*a
    xor edx, edx
    mov dx, [b]
    add ax,dx
;a*a+b=ax
    xchg ax,dx
;dx=a*a+b
    xor eax, eax
    mov al, [c]
    xor ecx, ecx
    mov cl, [a]
    div CL
; AL=c/a
    add al, [a]
;AL=c/a+a


    xchg al,cl
    xor eax, eax
    xchg ax,dx
    div CL
;AL
xor ebx, ebx
xor ecx, ecx
mov ebx, [x]
mov ecx, [x+4]
xor edx, edx
sub ecx, edx
sbb ebx, eax
;ecx:ebx

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
