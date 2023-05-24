bits 32 


global start        


extern exit               
import exit msvcrt.dll    

; 8.Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate literele mari din sirul S.
;  Exemplu:
; S: 'a', 'A', 'b', 'B', '2', '%', 'x', 'M'
; D: 'A', 'B', 'M'
segment data use32 class=data
    s db 'a', 'A', 'b', 'B', '2', '%', 'x', 'M'     ; declararea sirului initial s
    l equ $-s                                       ; stabilirea lungimea sirului initial l
    d times l db 0                                  ; rezervarea unui spatiu de dimensiune l pentru sirul destinatie d si initializarea acestuia


segment code use32 class=code
    start:
        mov ecx,l               ;punem lungimea in ECX pentru a putea realiza bucla loop de ecx ori -> ECX=8
        mov esi,0
        mov ebx,0
        jecxz final
        repeta:
            mov al,[s+esi]      ;punem in AL caracterele din sirul s de pe pozitia esi
            cmp al,'Z'          ;comparam caracterul din AL cu Z
            jbe majuscula       ;daca caracterul este mai mic sau egal decat Z se face saltul la instructiunea majuscula
            inc esi             ;altfel se incrementeaza ESI
            loop repeta
        jmp final
        majuscula:
            cmp al,'A'          ;comparam caracterul din AL cu A
            jae copiere         ;daca caracterul este mai mare sau egal decat A se face saltul la instructiunea copiere
            inc esi             ;altfel se incrementeaza ESI si se decrementeaza ECX
            dec ecx
            cmp ecx,0           ;comparam ECX cu 0
            je final            ;daca ECX este egal cu 0 se face saltul la instructiunea final
            jmp repeta          ;altfel se face saltul la instructiunea repeta
            
        copiere:
            mov [d+ebx],al      ;copiem caracterul din AL in D pe pozitia EBX
            inc ebx             ;incrementam EBX
            inc esi             ;incrementam ESI
            dec ecx             ;decrementam ECX
            cmp ecx,0           ;comparam ECX cu 0
            je final            ;daca ECX este egal cu 0 se face saltul la instructiunea final
            jmp repeta          ;altfel se face saltul la instructiunea repeta
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
