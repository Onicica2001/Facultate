bits 32 


global start        


extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    a db 10
    b db 50
    c db 70
    d dw 96h


segment code use32 class=code
    start:
        mov eax,0
        ;calculam c+b
        mov al,[c]
        add al,[b]
        mov dl,al
        ;calculam d/a
        mov ax,[d]
        mov bl,[a]
        div bl
        mov bl,al
        ;calculam(c+b-d/a)
        mov al,dl
        sub al,bl
        mov dl,al
        ;calculam 3*(c+b-d/a)
        mov al,3
        mul dl
        ;calculam [3*(c+b-d/a)-300]
        sub ax,300
        mov dx,ax
        ;calculam 200-[3*(c+b-d/a)-300]
        mov ax,200
        sub ax,dx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
