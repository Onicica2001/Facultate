bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;a - byte, b - word, c - double word, d - qword - Interpretare fara semn
segment data use32 class=data
     a db 10
     b dw 20
     c dd 50
     d dq 18

;1. c-(a+d)+(b+d)
segment code use32 class=code
    start:
        
    ; a+d
    mov al,[a]
    mov ah, 0   ; conversia AL -> AX
    mov dx, 0   ; conversia AX -> DX:AX
    
    push dx
    push ax
    pop eax
    
    mov edx,0   ; EDX:EAX = EAX

    add eax, dword[d]
    adc edx, dword[d+4] ; EDX:EAX = a + d
    
    
    ; b + d
    mov bx, [b] 
    mov cx, 0     ; conversia BX -> CX:BX
    
    push cx
    push bx
    pop  ebx      
    
    mov ecx, 0  ; ECX:EBX = EBX 
    
    add ebx, dword[d]
    adc ecx, dword[d+4] ; ECX:EBX = b + d
    
    ;(a+d)+(b+d)
    
    add eax, ebx  
    adc edx, ecx  ; EDX:EAX = (a+d)+(b+d)
    
    ;c-(a+d)+(b+d)
    
    mov ebx, [c]
    mov ecx, 0     ; EBX -> ECX:EBX
    
    sub ebx,eax
    sbb ecx,edx    ; c-(a+d)+(b+d)
    

    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
