; Exercitiul 17
;Se dau cuvantul A si octetul B. Sa se obtina dublucuvatul C:
;bitii 0-3 ai lui C au valoarea 1
;bitii 4-7 ai lui C coincid cu bitii 0-3 ai lui A
;bitii 8-13 ai lui C au valoarea 0
;bitii 14-23 ai lui C coincid cu bitii 4-13 ai lui A
;bitii 24-29 ai lui C coincid cu bitii 2-7 ai lui B
;bitii 30-31 au valoarea 1
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a-word b-byte c- double word
segment data use32 class=data
       a dw 0AACCh
       b db 0FFh
       c dw 0
segment code use32 class=code
    start:
        mov ebx,0 ;in registrul ebx vom calcula rezultatul
         
        ;bitii 0-3 ai lui C au valoarea 1
        or ebx, 00000000000000000000000000001111b  ;--> EBX=00000000000000000000000000001111b=00000000Fh
        
        ;bitii 4-7 ai lui C coincid cu bitii 0-3 ai lui A
        mov ax,[a]
        and ax, 0000000000001111b ; izolam bitii 0-3 ai lui A --> AX=0000000000001100b=000Ch
        mov cl,4
        rol ax,cl ; -->  AX=0000000011000000b=00C0h
        
        cwde   ; EAX=00000000000000000000000011000000b=000000C0h
        
        or ebx,eax  ; --> EBX=00000000000000000000000011001111b=0000000CFh
        
        ;bitii 8-13 ai lui C au valoarea 0
        and ebx,11111111111111111100000011111111b ; -->EBX=00000000000000000000000011001111b=0000000CFh
        
        ;bitii 14-23 ai lui C coincid cu bitii 4-13 ai lui A
        mov ax,[a]
        and ax, 0011111111110000b ; izolam bitii 4-13 ai lui A --> AX=0010101011000000b=2AC0h
        cwde  ; EAX=00000000000000000010101011000000b=00002AC0h
        mov cl,10 
        rol eax,cl ;--> EAX=00000000101010110000000000000000b=00AB0000
        or ebx,eax; --> EBX=00000000101010110000000011001111b=00AB00CFh
        
        ;bitii 24-29 ai lui C coincid cu bitii 2-7 ai lui B
        mov al, [b]
        and al,11111100b ;--> AL=11111100b=FCh
        mov ah,0 ; --> AX=0000000011111100b=00FCh
        mov dx,0 ; --> DX:AX=0000000011111100b=00FCh
        push dx
        push ax
        pop eax ;-->EAX=00000000000000000000000011111100b=000000FCh
        mov cl,22
        rol eax,cl ; -->EAX=00111111000000000000000000000000b=3F000000h
        or ebx,eax;--> EBX=00111111101010110000000011001111b=3FAB00CFh
        
        ;bitii 30-31 au valoarea 1
        or ebx, 11000000000000000000000000000000b
        mov [c],ebx ;--> --> EBX=11111111101010110000000011001111b=FFAB00CFh
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
