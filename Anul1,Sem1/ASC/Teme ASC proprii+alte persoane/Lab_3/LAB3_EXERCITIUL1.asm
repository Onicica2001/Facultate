bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;a - byte, b - word, c - double word, d - qword 
segment data use32 class=data
        a db 9
        b dw 2
        c dd 100
        d dq 50
; 14. (a+d)-(c-b)+c Interpretare fara semn
segment code use32 class=code
    start:
        ; c-b unde c-32 biti, b-16 biti 
        mov ax, word [c]
        mov dx, word [c+2] ; DX:AX=c

        mov bx,[b]
        mov cx, 0          ; conversia fara semn de la BX la CX:AX --> CX:BX= b
        
        sub ax,bx
        sbb dx,cx ; DX:AX= c-b
        
        push dx
        push ax
        pop eax ;EAX= c-b
        mov ebx,eax ; EBX= c-b ; pentru a putea folosi AX la urmatoarea operatie
        mov ecx,0 ;  conversia fara semn de la EBX la ECX:EBX  ----> ECX:EBX= c-b
       
        ;a+d unde a-8 biti si d-64 biti
        mov al,[a] ;
        mov ah, 0  ; conversia fara semn de la AL la AX
        mov dx, 0  ; conversia fara semn de la AX la DX:AX ----> DX:AX=a
        
        push dx
        push ax
        pop eax    ; EAX=a 
        
        mov edx,0 ; conversia fara semn de la EAX la ECX:EAX---> ECX:EAX=a
        add eax, dword[d]
        adc edx, dword[d+4] ; EDX:EAX= (a+d)
        
        ;(a+d)-(c-b)
         sub eax, ebx
         sbb edx, ecx ; EDX:EAX=(a+d)-(c-b)
         
         ;(a+d)-(c-b)+c unde c-32 biti
         mov bx,word[c]
         mov cx,word[c+2] ; CX:BX=c
         
         push cx
         push bx
         pop ebx          ;  EBX=c
         mov ecx,0   ;  conversia fara semn de la EBX la ECX:EBX
         
         add eax,ebx
         adc edx,ecx;  EDX:EAX=(a+d)-(c-b)+c
         
         
         ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

