bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global _Operatie        

segment data public data use32
    ; ...

; our code starts here
; 5. Se cere se se citeasca numerele a, b si c ; sa se calculeze si sa se afiseze a+b-c.
segment code public code use32
    _Operatie:
        ; ...
        ; Codul de intrare
        push ebp 
        mov ebp, esp 
        
    ; Se calculeaza rezultatul operatiei cerute
    clc 
    
    mov eax, 0
    mov edx, 0
    mov eax, [ebp + 8]
    add eax, [ebp + 12]
    adc edx, 0 
    sub eax, [ebp + 16] 
    sbb edx, 0
    
    ; Codul de iesire
    mov esp, ebp 
    pop ebp 
    
    ret 
    
   
