bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
segment data use32 class=data
    a db 20
    b dw 30
    c dd 25
    d dq 10

; 2 .(c+b)-a-(d+d)
segment code use32 class=code
    start:
        
        mov ax , [b]
        
        ;convertesc in interpretarea cu semn word-ul ax la dx:ax
        cwd ; dx:ax = b 
        
        mov bx , word [c+0]
        mov cx , word [c+2]
        ;cx:bx = c 
        
        ;calculez (c+b)
        
        add bx , ax 
        adc cx , dx 
        ;cx:bx = (c+b)
        
        mov al , [a]
        
        ;convertesc in interpretarea cu semn byte-ul al la ax 
        cbw ; ax = a 
        
        ;convertesc in interpretarea cu semn word-ul ax la dx:ax
        cwd ; dx:ax = a 
        
        ;calculez (c+b)-a
        
        sub bx , ax 
        sbb cx , dx 
        ;cx:bx = calculez (c+b)-a
        
        mov ax , bx 
        mov dx , ax 
        ;dx:ax = (c+b)-a
        
        push dx  
        push ax 
        pop eax 
        ; eax = (c+b)-a
        
        ;convertesc in interpretarea cu semn eax in qword-ul edx:eax 
        cdq ; edx:eax = (c+b)-a
        
        mov ebx , dword [d+0]
        mov ecx , dword [d+4]
        ;ecx:ebx = d 
        
        ;calculez (d+d)
        add ebx , ebx 
        adc ecx , ecx ; ecx:ebx = (d+d)
        
        ;calculez (c+b)-a-(d+d)
        
        sub eax , ebx 
        sbb edx , ecx 
        ; edx:eax = (c+b)-a-(d+d)
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
