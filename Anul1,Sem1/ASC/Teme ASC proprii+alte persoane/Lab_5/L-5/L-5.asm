bits 32 ; assembling for the 32 bits architecture


global start        


extern exit               
import exit msvcrt.dll    
                          


segment data use32 class=data
    s1 db 'a', 'b', 'c', 'd', 'e', 'f'
    l1 equ ($-s1)/2
    s2 db '1', '2', '3', '4', '5'
    l2 equ ($-s2)/2
    d times l2 db 0

; 12. Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor de pe pozitiile pare din S2 cu elementele de pe ;     pozitiile impare din S1.

; Exemplu:
;  S1: 'a', 'b', 'c', 'd', 'e', 'f'
;  S2: '1', '2', '3', '4', '5'
;  D: '2', '4','a','c','e'
segment code use32 class=code
    start:
        mov ecx, l2 ; punem lungimea celui de-al doilea sir  in ECX pentru a putea realiza bucla loop de ecx ori
        mov edi, 0
        mov esi, 1
        jecxz Sfarsit1
        Repeta:
            mov al, [s2+esi]
            mov [d+edi],al
            inc edi
            inc esi
            inc esi
        loop Repeta
        Sfarsit1
        
        mov ecx,l1
        mov esi,0
        jecxz Sfarsit2
        repeta:
            mov al, [s1+esi]
            mov [d+edi],al
            inc edi
            inc esi
            inc esi
        loop repeta
        Sfarsit2
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
