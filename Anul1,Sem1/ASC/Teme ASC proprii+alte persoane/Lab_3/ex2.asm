bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
segment data use32 class=data
    ; ...
    a db -45
    b dw 100
    c dd 70
    d dq -80

; b+c+d+a-(d+c)  => 55
segment code use32 class=code
    start:
        ; calculam b+c
        ; convertim cu semn b la c
        mov ax, [b]
        cwd  ; => DX:AX = b
        add ax, word [c]
        adc dx, word [c+2] ; => DX:AX = b+c
        
        ; calculam b+c+d 
        ; convertim DX:AX la un qword in EDX:EAX
        
        push dx
        push ax
        pop eax
        
        cdq ;  => EDX:EAX = b+c
        
        add eax, dword [d]
        adc edx, dword [d + 4] ; ==> EDX:EAX = b+c+d
        
        ; calculam b+c+d+a
        ; mutam EAX in EBX pentru a folosi EAX la conversie, iar EDX:EBX = b+c+d
        mov ebx, eax  ; => EDX:EBX = b+c+d
        mov al, [a]
        cbw
        cwde   ; => EAX = e
        clc
        add ebx, eax  ; => EDX:EBX = b+c+d+a
        mov ecx, edx  ; => ECX:EBX = b+c+d+a
        
        ; calculam d+c in EAX
        mov eax, [c]  ; => EAX = c
        cdq     ; ==> EDX:EAX = c
        add eax, dword [d] 
        adc edx, dword [d+4]  ; => EDX:EAX = c+d
        
        ; calculam c+d+a-(d+c) = ECX:EBX - EDX:EAX
        sub ebx, eax 
        sbb ecx, edx   ; ==> Rezultat in ECX:EDX
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
