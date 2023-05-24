bits 32 


global start        


extern exit               
import exit msvcrt.dll    
    ;a,c,d-byte, f-word
segment data use32 class=data
    a db 21
    c db 17
    d db 14
    f dw 100h
    ;18. f+(c-2)*(3+a)/(d-4)
segment code use32 class=code
    start:
        mov eax,0       ;EAX=0
        ;calculam c-2
        mov al,[c]      ;AL=c=17
        sub al,2        ;AL=AL-2=17-2=15
        mov dl,al       ;DL=AL=15
        ;calculam 3+a
        mov al,3        
        add al,[a]      ;AL=AL+a=3+21=24
        ;calculam (c-2)*(3+a)
        mul dl          ;AX=AL*DL=24*15=360
        mov dx,ax       ;DX=AX=360
        ;calculam d-4
        mov al,[d]      ;AL=d=14
        sub al,4        ;AL=AL-4=14-4=10
        mov bl,al       ;BL=AL=10
        ;calculam (c-2)*(3+a)/(d-4)
        mov ax,dx       ;AX=DX=360
        div bl          ;AL=AX/BL=360:10=36
        ;calculam f+(c-2)*(3+a)/(d-4)
        mov ah,0        ;AH=0
        add ax,[f]      ;AX=AX+f=36+100h=36+256=292
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
