bits 32 
global start        
extern exit               
import exit msvcrt.dll   
segment data use32 class=data
    ; Se da un cuvant A. Sa se obtina dublucuvantul B astfel:
    ; bitii 0-3 ai lui B sunt 0
    ; bitii 4-7 ai lui B sunt bitii 8-11 ai lui A
    ; bitii 8-9 si 10-11 ai lui B sunt bitii 0-1 inversati ca valoare ai lui A (deci de 2 ori) 
    ; bitii 12-15 ai lui B sunt biti de 1
    ; bitii 16-31 ai lui B sunt identici cu bitii 0-15 ai lui B.

    a dw 1011100101001101b
    b dd 0

segment code use32 class=code
    start:
        mov bx, 0
        mov cx, 0
        
        ; bitii 0-3 ai lui B sunt 0
        and bx, 1111111111110000b       ;zerorizez bitii 0-3
        
        ; bitii 4-7 ai lui B sunt bitii 8-11 ai lui A
        mov ax, [a]
        and ax, 0000111100000000b       ;pastrez numai bitii 8-11
        shr ax, 4                       ;bitii 8-11 se muta pe pozitiile 4-7
        or bx, ax                       ;concatenez la valoarea finala
        
        ; bitii 8-9 si 10-11 ai lui B sunt bitii 0-1 inversati ca valoare ai lui A (deci de 2 ori)
        mov ax, [a]
        not ax                          ;inversez bitii lui A
        and ax, 0000000000000011b       ;pastrez numai bitii 0-1      
        shl ax, 8                       ;bitii 0-1 se muta pe pozitiile 8-9
        or bx, ax                       ;concatenez la valoarea finala
        shl ax, 2                       ;bitii 8-9 se muta pe pozitiile 10-11
        or bx, ax                       ;concatenez la valoarea finala
        
        ; bitii 12-15 ai lui B sunt biti de 1
        or bx, 1111000000000000b        ;fortez la 1 bitii 12-15

        ; bitii 16-31 ai lui B sunt identici cu bitii 0-15 ai lui B
        mov cx, bx                      ;CX:BX = numarul cautat
        
        mov [b], cx
        mov [b+2], bx
        
        push    dword 0      
        call    [exit]       
