bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern printf, scanf
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll  

; our data is declared here (the variables needed by our program)
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Se citesc de la tastatura doua numere a si b. Sa se calculeze valoarea expresiei (a/b)*k, k fiind o constanta definita in segmentul de date. ; Afisati valoarea expresiei (in baza 2).
segment data use32 class=data
    msj1 db "Dati numarul a = ", 0 
    msj2 db "Dati numarul b = ", 0 
    format db "%d", 0 
    formats db "%s", 0 
    k dw 10 
    a dd 0 
    b dd 0 
    nrbaza2 times 32 db -1
; our code starts here
segment code use32 class=code
    start:
        ; voi apela functia printf(msj1)  
        push dword msj1 
        call [printf]
        add esp, 4 * 1 
        ; voi apela scanf(format, a) = > se va citi un numar decimal in variabila a 
        push a
        push dword format 
        call [scanf] 
        add esp, 4*2 ; eliberez parametrii de pe stiva 
        ; voi apela functia printf(msj1)  
        push dword msj2 
        call [printf] 
        add esp, 4*1 
        
        ; voi apela scanf(format, b) = > se va citi un numar decimal in variabila b 
        push dword b
        push dword format 
        call [scanf]
        add esp, 4*2 
        ;efectuez impartirea 
        
        mov eax, [a]
        push eax 
        pop ax 
        pop dx ; in DX:AX = a 
        
        mov ebx, 0 
        mov ebx,[b] ; bx = b 
        div bx  ; AX = a/b          DX = a % b 
        
        mov bx, [k] 
        mul bx ; DX:AX = AX * bx = (a/b) * k 
        push dx
        push ax 
        pop eax  ; eax = (a/b)*k 
        mov ecx, 32 
        mov ebx, 32 
        repeta:
        test eax, 01h         
        ; check ZF 
        jz e_zero
        ; nu e zero 
        mov byte [nrbaza2+ebx], '1' 
   
    jmp skip
    e_zero:
        mov byte [nrbaza2+ebx], '0' 
    skip:
        dec ebx
        ror eax, 1 
    loop repeta
    
        ; voi apela functia printf(formats, nrbaza2)
        push nrbaza2
        push dword formats
        
        call [printf] 
        add esp, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
