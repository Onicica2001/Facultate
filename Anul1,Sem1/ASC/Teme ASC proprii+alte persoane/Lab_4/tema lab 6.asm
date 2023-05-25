bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dd 10
    b dw 20
    c dw 0
    
; Se da dublucuvantul A si cuvantul B. Sa se formeze cuvantul C:
; bitii 0-4 ai lui C sunt invers fata de bitii 20-24 ai lui A
; bitii 5-8 ai lui C sunt 1
; bitii 9-12 ai lui C sunt identici cu bitii 12-15 ai lui B
; bitii 13-15 ai lui C sunt bitii 7-9 ai lui A
segment code use32 class=code
    start:
        mov bx, 0
        
        ; bitii 0-4 ai lui C sunt invers fata de bitii 20-24 ai lui A
        mov eax, [a]
        or eax, 11111110000011111111111111111111b
        shr eax, 20
        not ax
        or bx, ax
        
        ; bitii 5-8 ai lui C sunt 1
        or bx, 0000000111100000b
        
        ; bitii 9-12 ai lui C sunt identici cu bitii 12-15 ai lui B
        mov ax, [b]
        and ax, 1111000000000000b
        shr ax, 3
        or bx, ax
        
        ; bitii 13-15 ai lui C sunt bitii 7-9 ai lui A
        mov ax, [a+2]
        and ax, 0000001110000000b
        shl ax, 6
        or bx, ax
        
        mov [c], bx
        
        push    dword 0
        call    [exit]
