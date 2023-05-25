bits 32 

global start        

extern exit, printf, scanf         
import exit msvcrt.dll 
import printf msvcrt.dll
import scanf msvcrt.dll

; 20. Sa se citeasca de la tastatura in baza 16 doua numere a si b de tip dword si sa se afiseze suma partilor low si diferenta partilor high. Exemplu:
; a = 00101A35h, b = 00023219h
; suma = 4C4Eh
; diferenta = Eh
segment data use32 class=data
    format db "%x", 0
    mesaj1 db "a=", 0
    a dd 0
    mesaj2 db "b=", 0
    b dd 0
    mesaj3 db "suma=%x", 0Ah, 0
    mesaj4 db "diferenta=%x", 0

segment code use32 class=code
    start:
        ; apelam functia printf pentru a afisa "a="
        push dword mesaj1
        call [printf]
        add esp, 4*1
        
        ; apelam functia scanf pentru a il citim pe a
        push dword a
        push dword format
        call [scanf]
        add esp, 4*2
        
        ; apelam functia printf pentru a afisa "b="
        push dword mesaj2
        call [printf]
        add esp, 4*1
        
        ; apelam functia scanf pentru a il citim pe b
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        
        ; suma partilor low
        mov eax, [a]
        mov ebx, [b]
        and eax, 0000FFFFh ; izolam partea low a valorii din eax(=a)
        and ebx, 0000FFFFh ; izolam partea low a valorii din ebx(=b)
        add eax, ebx
        
        push dword eax
        push dword mesaj3
        call [printf]
        add esp, 4*2
        
        ; diferenta partilor high
        mov eax, [a]
        mov ebx, [b]
        shr eax, 16 ; mutam bitii 16-31 din eax(=a) in bitii 0-15, operatia shr urmand sa puna pe bitii 16-31 valoarea 0
        shr ebx, 16 ; mutam bitii 16-31 din ebx(=b) in bitii 0-15, operatia shr urmand sa puna pe bitii 16-31 valoarea 0
        sub eax, ebx
        
        push dword eax
        push dword mesaj4
        call [printf]
        add esp, 4*2
        
        push    dword 0     
        call    [exit]    
