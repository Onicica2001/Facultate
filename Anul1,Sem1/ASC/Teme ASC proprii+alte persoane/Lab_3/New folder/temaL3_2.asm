bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;a - byte, b - word, c - double word, d - qword - Interpretare cu semn
segment data use32 class=data
     a db 10
     b dw 20
     c dd 50
     d dq 18
    
; 1. (c+b+a)-(d+d)
; our code starts here
segment code use32 class=code
    start:
    ; a+b
    mov al,[a]
    cbw            ;  conversia AH -> AX
    adc ax,word[b] ; AX = a + b
    
    ; (c+b+a) 
    cwd            ;   conversia AX -> DX:AX
    
    adc ax, word[c]
    adc dx, word[c+2]  ; DX:AX = (c+b+a)

    push dx
    push ax
    pop eax    ; EAX = (c+b+a)
    
    cdq         ; conversia EAX -> EDX:EAX
    
    ;  d+d
    mov ebx,dword[d]
    mov ecx,dword[d+4]
    
    adc ebx,dword[d] 
    adc ecx,dword[d+4] ; ECX:EBX = d + d

    ; (c+b+a)-(d+d)
    sbb eax,ebx
    sbb edx,ecx  ; EDX:EBX = (c+b+a)-(d+d)   
    
  
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
