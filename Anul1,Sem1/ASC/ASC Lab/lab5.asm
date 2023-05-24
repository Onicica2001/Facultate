bits 32 


global start        


extern exit               
import exit msvcrt.dll    


segment data use32 class=data
    a dw 100
    b dd 200
    c dq 300

; Calculati valoarea expresiei: c/b+a
segment code use32 class=code
    start:
        ;calculam c/b
        mov eax,dword [c]
        mov edx, dword [c+4]
        mov ebx,[b]
        div ebx
        
        ;calculam c/b+a
        mov cx,[a]
        mov bx,0
        push bx
        push cx
        pop ecx
        add eax,ecx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
