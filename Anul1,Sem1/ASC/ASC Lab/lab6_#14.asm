bits 32 


global start        


extern exit               
import exit msvcrt.dll    
; 14.Se da un sir S de dublucuvinte.
;Sa se obtina sirul D format din octetii dublucuvintelor din sirul D sortati in ordine crescatoare in interpretarea fara semn.
;  Exemplu:
;s DD 12345607h, 1A2B3C15h
;d DB 07h, 12h, 15h, 1Ah, 2Bh, 34h, 3Ch, 56h

segment data use32 class=data
    s dd 12345607h, 1A2B3C15h
    len_s equ $-s
    d times len_s db -1


segment code use32 class=code
    start:
        mov esi, s                      ;ESI=s
        mov edi, d                      ;EDI=d
        cld                             ;DF=0
        mov ecx, len_s                  ;ECX=len_s=8
        jecxz final                     ;Daca ECX=0 sare la final
        repeta:
            movsb                       ;In EDI se incarca un octet din ESI + EDI=EDI+1 + ESI=ESI+1
            loop repeta
        mov dx,1                        ;DX=1 ca valoare de adevar
        while_loop:
            cmp dx,0                    ;Verifica daca DX este 0
            je while_final              ;Daca DX este 0 inseamna ca este fals si sarim la finalul while-ului
            mov esi,d                   ;ESI=d
            mov dx,0                    ;DX=0
            mov ecx,len_s-1             ;ECX=len_s=8
            for_loop:
                mov al, [esi]           ;AL=d[i]
                cmp al, [esi+1]         ;if(d[i+1]<d[i])
                jbe mai_departe         ;daca d[i+1]>d[i] sare la instructiunea mai_departe
                    mov ah, [esi+1]     ;AH=d[i+1]
                    mov [esi], ah       ;d[i]=AH
                    mov [esi+1], al     ;d[i+1]=AL
                    mov dx, 1           ;DX=1
                mai_departe:
                inc esi                 ; i++
                loop for_loop
                jmp while_loop
        while_final:
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
