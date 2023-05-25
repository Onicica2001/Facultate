bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a-byte; b-word; c-doubleword; x-qword
segment data use32 class=data
        a db 3
        b dw 12
        c dd 26
        x dq 200
; 14. x+(2-a*b)/(a*3)-a+c -Interpretarea CU semn
segment code use32 class=code
    start:
        ;a*b
        mov al,[a]    ; AL=a
        cbw           ; conversia cu semn de la AL la AX
        imul word [b] ; imul<op16>-->  DX:AX=AX*<op16>  --> DX:AX= a*b
        
        push dx       ; punem pe stiva pentru a lua de pe stiva ulterior intrucat vrem sa ne folosim de AX
        push ax
        pop eax       ; EAX=a*b
        
        push eax
        pop cx
        pop bx        ; BX:CX=a*b
        
        
        ;2-a*b
        mov al,2      ; AL=2
        cbw           ;conversia cu semn de la AL la AX
        cwd           ;conversia cu semn de la AX la DX:AX  ---> DX:AX=2
        sub ax,cx
        sbb dx,bx     ;DX:AX= 2-a*b
        
        push dx
        push ax
        pop ebx       ;EBX=2-a*b
        
        ; a*3
        mov al,3      ;AL=3
        imul byte [a] ;imul<op8> --->  AX= AL*<op8> --->   AX=a*3
        mov cx,ax     ;CX=a*3
        
        push ebx
        pop ax
        pop dx        ;DX:AX=2-a*b
         
        ;(2-a*b)/(a*3) - 16 biti
        idiv cx       ; idiv<reg16> --->  AX=DX:AX/<reg16> --->AX= (2-a*b)/(a*3)  ( In DX este restul, dar noi mergem mai deparde doar cu  catul)
        
        ;(2-a*b)/(a*3)-a unde a- 8 biti
        mov bx,ax      ; BX=(2-a*b)/(a*3)  Avem nevoie de AX
        mov al,[a]
        cbw            ; conversia cu semn de la AL la AX  ----> AX=a
        sub bx,ax      ; BX=BX-AX= (2-a*b)/(a*3)-a
        mov ax, bx     ; AX= (2-a*b)/(a*3)-a
        cwd            ; conversia cu semn de la AX la DX:AX ----> DX:AX= (2-a*b)/(a*3)-a
        
        ;(2-a*b)/(a*3)-a+c unde c-32 biti
        mov bx,word[c]
        mov cx,word[c+2]  ; CX:BX=c
        add ax,bx
        adc dx,cx         ; DX:AX=(2-a*b)/(a*3)-a+c
        push dx
        push ax
        pop eax           ; EAX=AX= (2-a*b)/(a*3)-a+c
        cdq  ;  conversia cu semn de la EAX la EDX:EAX ----> EDX:EAX=(2-a*b)/(a*3)-a+c
        
        ;x+(2-a*b)/(a*3)-a+c unde x-64  biti
        mov ebx, dword[x]
        mov ecx, dword[x+4]; ECX:EBX=x
        add ebx,eax
        adc ecx,edx       ; ECX:EBX=x+(2-a*b)/(a*3)-a+c
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
