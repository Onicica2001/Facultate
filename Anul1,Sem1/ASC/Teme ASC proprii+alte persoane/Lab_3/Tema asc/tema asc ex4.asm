bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b,c-byte; e-doubleword ; x - quadword
segment data use32 class=data
    ;; 
    a db 2
    b db 4
    c db 3
    e dd 40
    x dq 200
; x-(a*b*25+c*3)/(a+b)+e
segment code use32 class=code
    start:
        mov eax, 0
        mov al, [a]
        imul byte [b]    ; AX = Al * b = a * b 
        
        mov ebx, 0
        mov bx, 25
        imul bx         ; EAX = AX * BX = a * b * 25
        
        mov ebx, eax    ; EBX = a * b * 25
        mov eax, 0
        
        mov al, [c]
        mov ah, 3
        imul ah          ; AX = c * 3 
        cwde
        
        add ebx, eax    ; EBX = EBX + EAX = a * b * 25 + c * 3
        
        mov eax, 0
        mov ecx, 0
        mov al, [a]     
        mov ah, [b]
        add al, ah      ; AL = AL + AH = a + b 
        mov ah, 0
        cwde
        
        mov ecx, [e]    
        add ecx, eax    ; ECX = ECX + EAX = (a + b) + e 
        mov eax, 0
        
        mov edx, 0
        mov eax, [x]
        mov edx, [x+4]
        
        sub eax, ebx    ; EAX = EAX - EBX = x-(a*b*25+c*3)
        idiv ecx        ; EDX:EAX / ECX = EAX catul si in EDX restul = x-(a*b*25+c*3)/(a+b)+e
        
        
        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
