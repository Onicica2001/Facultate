bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

segment data use32 class=data
        ;a - byte, b - word, c - double word, d - qword - Interpretare fara semn
        a db 11
        b dw 20
        c dd 30
        d dq 40

; our code starts here
segment code use32 class=code
    start:
        ;a+b-c+(d-a)
        mov ebx, 0
        mov bx, [b]     ; BX = b 
        mov cl, [a]     ; CL = a 
        mov ch, 0       ; CX = a 
        add bx, cx      ; BX = BX + CX 
        
        mov ecx, 0
        mov ecx, [c]    ; ECX = c 
        sub ebx, ecx    ; EBX = EBX - ECX 
        
        mov eax, 0
        mov eax, [d]    ; punem partea mai putin semnificativa a lui d in EAX
        mov edx, 0      
        mov edx, [d+4]   ; punem partea mai semnificativa a lui d in EDX 
        
        mov ecx, 0
        mov cl, [a]     ; CL = a 
        
        sub eax, ecx    ; EAX = EAX - ECX 
        
        add ebx, eax    ; rezultatul se afla in ebx 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
