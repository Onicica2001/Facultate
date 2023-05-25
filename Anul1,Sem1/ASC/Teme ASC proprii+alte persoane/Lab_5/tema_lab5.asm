; Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R 
; care sa contina elementele lui B in ordine inversa urmate de elementele pare ale lui A
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 2, 1, 3, 3, 4, 2, 6  ; Sirul A de octeti
    lenA equ $-a ; Lungimea sirului A
    b db 4, 5, 7, 6, 2, 1  ; Sirul B de octeti
    lenB equ $-b  ; Lungimea sirului B
    r times lenA+lenB db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; Punem prima data elementele sirului B in ordine inversa
        mov ecx, lenB
        jecxz pare_din_A
        
        mov esi, 0
        mov edi, lenB
        dec edi
        
    repeta1:
        mov al, [b + edi]
        mov [r + esi], al
        inc esi
        dec edi
        loop repeta1
    
    
    pare_din_A:
    
        mov ecx, lenA
        jecxz final
        
        mov edi, 0
    
    repeta2:
        mov al, [a + edi]
        ; Verificam daca al este par
        test al, 01h  ; Daca ZF = 1 => Al este par ; ZF = 0 => AL este impar
        jnz peste
        mov [r + esi], al
        inc esi
    
    peste:
        inc edi
        loop repeta2
        
    final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
