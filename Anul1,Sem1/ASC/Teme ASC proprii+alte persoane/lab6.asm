bits 32 
global start        
extern exit           
import exit msvcrt.dll   

; Se da un sir de octeti s
segment data use32 class=data
    s db 5, 25, 55, 127
    len equ $-s
    d times len db 0
;4.Sa se construiasca sirul de octeti d, care contine pe fiecare pozitie numarul de biti 1 ai octetului de pe pozitia corespunzatoare din s
segment code use32 class=code
    start:
        mov ecx,len
        jecxz Final        
        cld                
        mov esi,s
        mov edi,0      
        Repetam:
         lodsb        ;AL= s[i]+ inc EDI
        Repeta:
            test al,01h ; Verificam  dala ultima cifra a numarului este 1
            je Miau     ; Daca este zero sarim la pasul Miau, altfel incrementam valoarea din [d+edi]
            mov bl,[d+edi]
            inc bl
            mov [d+edi],bl
            Miau:
            shr al,1    ; Rotim spre dreapta cifrele din AL
            cmp al,0    ; Comparam continutul din AL cu 0
            jne Repeta  ; Continuam sa executam Repeta daca in AL nu este zero!
            inc edi
            loop Repetam ; Continuam sa executam Repetam daca ECX!=0 si in AL avem 0     
        Final:
           ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
