bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a-byte; b-word; c-doubleword; x-qword
segment data use32 class=data
        a db 1
        b dw 1
        c dd 26
        x dq 200
; 14. x+(2-a*b)/(a*3)-a+c  Interpretarea fara semn
segment code use32 class=code
    start:
        ; a*b
        mov al,[a]
        mov ah,0     ; conversia fara semn de la AL la AX ----->  AX=a
        mul word [b] ; DX:AX=AX*b= a*b
        
        ;2-a*b
        mov bl,2     ; 
        mov bh, 0    ; conversia fara semn de la BL la BX
        mov cx,0     ; conversia fara semn de la BX la CX:BX
        sub bx,ax    
        sbb cx,dx    ; CX:BX= 2-a*b
        
        push cx
        push bx
        pop ebx
        
        ;a*3
        mov al,3
        mul byte [a]  ; AX=AL*a=a*3
        mov cx,ax     ; CX=AX=a*3
        mov eax,ebx   ; EAX=2-a*b
        mov bx,cx     ; BX=a*3
 
        push eax
        pop ax
        pop dx  ; DX:AX=2-a*b
        
        div bx ; AX=(2-a*b)/(a*3)
        mov bl,[a]
        mov bh,0
        sub ax,bx ; AX=(2-a*b)/(a*3)-a
        mov dx,0 ;  DX:AX=(2-a*b)/(a*3)-a
        
        ;(2-a*b)/(a*3)-a+c
        mov bx,[c]
        mov cx,[c+2] ; cx:bx=c
        add ax,bx
        adc dx,cx ; DX:AX=(2-a*b)/(a*3)-a+c
        
        push dx
        push ax
        pop eax
        mov edx,0 ;  EDX:EAX=(2-a*b)/(a*3)-a+c
        
        ;x+(2-a*b)/(a*3)-a+c
        mov ebx, dword[x]
        mov ecx, dword[x+4] ; ecx:ebx=x
        add eax,ebx
        adc edx,ecx ; EDX:EAX=x+(2-a*b)/(a*3)-a+c
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
