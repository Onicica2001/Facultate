bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
segment data use32 class=data
    a db 20
    b dw 30
    c dd 25
    d dq 10
    r resw 1 
    
; 2. (b+b)+(c-a)+d
segment code use32 class=code
    start:
        
        ;calculez (b+b)
        mov bx , [b]
        add bx , [b] ; bx = (b+b)
        mov [r] , bx ; r = bx salvez continutul lui bx in r 
        
        mov al , [a]
        
        ;convertesc in interpretare fara semn byte-ul al la ax 
        mov ah , 0 ; ax = a 
        
        ;convertesc in interpretare fara semn word-ul ax la dx:ax 
        mov dx , 0 ; dx:ax = a 
        
        mov bx , word [c+0]
        mov cx , word [c+2]
        ;cx:bx = c 
        
        ;calculez (c-a)
        sub bx , ax 
        sbb cx , dx 
        ;cx:bx = (c-a)
        
        mov ax , [r] ; ax = (b+b)
        
        ;convertesc in interpretare fara semn word-ul ax la dx:ax
        mov dx , 0 ; dx:ax = (b+b)
        
        ;calculez (b+b)+(c-a)
        add ax , bx 
        adc dx , cx 
        ;dx:ax = (b+b)+(c-a)
        
        push dx 
        push ax 
        pop eax 
        ;eax = (b+b)+(c-a)
        
        ;convertesc eax in interpretare fara semn la qword edx:eax 
        
        mov edx , 0
        ;edx:eax = (b+b)+(c-a)
        
        mov ebx , dword [d+0]
        mov ecx , dword [d+4]
        ;ecx:ebx = d 
        
        ;calculez (b+b)+(c-a)+d
        add eax , ebx 
        adc edx , ecx
        ;edx:eax = (b+b)+(c-a)+d
       
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
