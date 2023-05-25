bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
     a db 01001001b
     b dw 1001101011100010b
     c dd 0

; 23. Se da octetul A si cuvantul B. Sa se formeze dublucuvantul C:
; - bitii 24-31 ai lui C sunt bitii lui A
; - bitii 16-23 ai lui C sunt inversul bitilor din octetul cel mai putin semnificativ al lui B
; - bitii 10-15 ai lui C sunt 1
; - bitii 2-9 ai lui C sunt bitii din octetul cel mai semnificativ al lui B
; - bitii 0-1 se completeaza cu valoarea bitului de semn al lui A
segment code use32 class=code
    start:
        mov ebx, 0
        
        ;- bitii 24-31 ai lui C sunt bitii lui A
        mov al, [a]
        mov ah, 0
        mov dx, 0          ;DX:AX=a
        
        push dx
        push ax
        pop eax            ;EAX=a
        
        rol eax, 24        ;deplasam 24 pozitii spre stanga
        
        or ebx, eax        ;punem bitii in rezultat
        
        ;- bitii 16-23 ai lui C sunt inversul bitilor din octetul cel mai putin semnificativ al lui B
        mov ax, [b]
        mov dx, 0           ;DX:AX=0
        
        push dx
        push ax
        pop eax             ;EAX=b
        
        not eax             ;inversam valoarea lui b
        
        and eax, 00000000000000000000000011111111b     ;izolam bitii din octetul cel mai putin semnificativ al lui b 
        
        rol eax, 16         ;deplasam bitii 16 pozitii spre stanga
        
        or ebx, eax         ;punem bitii in rezultat
        
        ;- bitii 10-15 ai lui C sunt 1
        or ebx, 00000000000000001111110000000000b      ;facem bitii 10-15 din rezultat sa aiba valoarea 1
        
        ;- bitii 2-9 ai lui C sunt bitii din octetul cel mai semnificativ al lui B
        mov ax, [b]
        mov dx, 0           ;DX:AX=b
        
        push dx
        push ax
        pop eax             ;EAX=b
        
        and eax, 00000000000000001111111100000000b     ;izolam bitii din octetul cel mai semnificativ al lui b 
        
        ror eax, 6          ;deplasam bitii 6 pozitii spre dreapta
        
        or ebx, eax         ;punem bitii in rezultat
        
        ;- bitii 0-1 se completeaza cu valoarea bitului de semn al lui A
        mov al, [a]
        mov ah, 0
        mov dx, 0           ;DX:AX=a
        
        push dx
        push ax
        pop eax             ;EAX=a
        
        and eax, 00000000000000000000000000000000b     ;izolam bitul de semn al lui A
        
        or ebx, eax         ;punem bitii in rezultat
        
        mov [c], ebx        ;punem valoarea din registru in variabila rezultat
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
