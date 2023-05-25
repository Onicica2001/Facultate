bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
     s1 db 'a', 'b', 'c', 'b', 'e', 'f' 
     len1 equ $-s1
     s2 db '1', '2', '3', '4', '5'      
     len2 equ $-s2
     d times len1+len2 db 0

; 16. Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor de pe pozitiile impare din S2 cu elementele de pe pozitiile pare din S1.
segment code use32 class=code
    start:
        mov ecx, len2/2 + 1                 ;punem lungimea celui de-al doilea sir in ECX pentru a putea realiza bucla loop de ECX ori 
        jecxz final_1
        
        mov esi, 0                 
        mov edi, 0                
        mov ebx, 0
        
    repeta1:
        mov al, [s2+esi]           
        mov [d+ebx], al
        add esi, 2
        inc ebx
        
    loop repeta1
    
    final_1:
    
        mov ecx, len1/2                      ;punem lungimea primului sir in ECX pentru a putea realiza bucla loop de ECX ori
        jecxz final
    
    repeta2:
        inc edi
        mov al, [s1+edi]                     
        mov [d+ebx], al
        inc edi
        inc ebx
    loop repeta2  

    final:   
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
