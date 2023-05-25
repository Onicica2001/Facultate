bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a,b,c-byte; e-doubleword ; x - quadword
    a db 3
    b db 2
    c db 4
    e dd 10
    x dq 300

; our code starts here
segment code use32 class=code
    start:
        ;x-(a*b*25+c*3)/(a+b)+e
        mov eax, 0
        mov al, [a]
        mul byte [b]    ; AX = AL * b = a * b 
        mov ebx, 0
        mov bx, 25
        mul bx          ; EAX = AX * BX = a * b * 25 

        mov ebx, 0
        mov ebx, eax    ; EBX = EAX 
        mov eax, 0
        mov al, [c]
        mov ah, 3
        mul ah          ; AX = AL * 3 =  c * 3

        add ebx, eax    ; EBX = EBX + EAX 
        mov eax, 0
        
        mov eax, [x]
        mov edx, [x+4]
        sub eax, ebx    ; EBX = EBX - EAX 
        
        mov ecx, 0      
        mov cl, [a]
        mov ch, [b]
        add cl, ch      ; CL = CL + CH = a + b 
        mov ch, 0
        
        mov edx, 0
        mov edx, [e]
        add ecx, edx 
        
        mov edx, 0
        mov edx, [x+4]
        div ecx         ; EDX:EAX / ECX = EAX catul si in EDX restul =  x-(a*b*25+c*3)/(a+b)+e
         
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
