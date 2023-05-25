bits 32 

global start        

extern exit, printf, scanf  
import exit msvcrt.dll  
import printf msvcrt.dll
import scanf msvcrt.dll

; Sa se citeasca de la tastatura doua numere a si b de tip word. Sa se afiseze in baza 16 numarul c de tip dword pentru care partea low este suma celor doua numere, iar partea high este diferenta celor doua numere. Exemplu:
; a = 574, b = 136
; c = 01B602C6h
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    c dd 0      ;   c = 01B602c6
    format db '%d', 0
    formata db 'Introduceti valoarea lui a = ', 0
    formatb db 'Introduceti valoarea lui b = ', 0
    mesajFinal db 'Valoarea lui c este: %x', 0

segment code use32 class=code
    start:
        ; ...
        ; Citim a
        push dword formata
        call [printf]
        add esp, 4 * 1
        
        push dword a
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        ; Citim b
        push dword formatb
        call [printf]
        add esp, 4*1
        
        push dword b
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        ; Vom a si b in EDX si vom scadea a si b in EBX 
        ; Dupa care vom lua DX si BX si le vom pune pe stiva si de pe stiva pe eax
        
        mov edx, [a]
        add edx, [b]
        
        mov ebx, [a]
        sub ebx, [b]
        
        push bx
        push dx
        pop eax
        
        pushad
        
        push dword eax
        push dword mesajFinal
        call [printf]
        add esp, 4*3
        
        popad
        
        push    dword 0     
        call    [exit]       
