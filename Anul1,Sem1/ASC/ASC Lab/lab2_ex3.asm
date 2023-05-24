bits 32 


global start        


extern exit               
import exit msvcrt.dll    


segment data use32 class=data
    a dw 100h
    b dw 101
    c dw 110
    d dw 24

segment code use32 class=code
    start:
        mov eax,0
        ;calculam a-b
        mov ax,[a]
        sub ax,[b]
        ;calculam (a-b-c)
        sub ax,[c]
        mov dx,ax
        ;calculam a-c
        mov ax,[a]
        sub ax,[c]
        ;calculam a-c-d
        sub ax,[d]
        ;calculam (a-c-d-d)
        sub ax,[d]
        mov bx,ax
        ;calculam (a-b-c)+(a-c-d-d)
        mov ax,dx
        add ax,bx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
