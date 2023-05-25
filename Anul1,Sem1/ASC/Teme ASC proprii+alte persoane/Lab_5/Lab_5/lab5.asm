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
;Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina elementele lui B in ordine inversa urmate de elementele in ordine inversa ale lui A.

    A db 2, 1, -3, 0 
    len_A equ $-A
    B db 4, 5, 7, 6, 2, 1 
    len_B equ $-B
    R times len_A+len_B db 0 

; our code starts here
segment code use32 class=code
    start:
        mov ecx, len_B                  ; punem lungimea sirului B in ECX
        mov esi, 0                      
        mov edi, len_B - 1            ; in edi punem lungimea sirului B pentru al putea parcurge in sens invers  
        
    repetaB:
        mov al, [B+edi]                 ; parcurgem in sens invers B
        mov [R+esi], al                 ; se construieste R
        inc esi 
        dec edi 
        test ecx, ecx 
        je prelucrareA
    loop repetaB 
    
    prelucrareA:
        mov ecx, len_A                  ; punem in ecx lungimea sirului A 
        mov edi, len_A - 1              ; in edi punem lungimea sirului A pentru al putea parcurge in sens invers  
        jecxz final
        
     repetaA:
        mov al, [A+edi]                 ; parcurgem invers sirul A
        mov [R+esi], al                 ; se construieste  R
        inc esi 
        dec edi 
    loop repetaA
        
    final:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
