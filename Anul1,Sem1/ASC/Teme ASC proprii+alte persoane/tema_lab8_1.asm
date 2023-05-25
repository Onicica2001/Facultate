bits 32
global start        


extern exit, printf, scanf              
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

    
segment data use32 class=data
  
    ; Sa se citeasca de la tastatura un numar in baza 10 si un numar in baza 16. 
    ; Sa se afiseze in baza 10 numarul de biti 1 ai sumei celor doua numere citite. Exemplu:
    ; a = 32 = 0010 0000b
    ; b = 1Ah = 0001 1010b
    ; 32 + 1Ah = 0011 1010b
    ; Se va afisa pe ecran valoarea 4.
    
    a dd 0
    b dd 0
    numar dd 0
    mesaj1 db "Cititi primul numar:", 0
    mesaj2 db "Cititi al doilea numar:", 0
    format1 db "%d", 0
    format2 db "%x", 0
    format3 db "Numarul de biti 1 ai sumei: %d", 0
    
segment code use32 class=code
    start:
        push dword mesaj1
        call [printf]
        add esp, 4 * 1              ; Se afiseaza mesajul de citire al primului numar
        
        push dword a
        push dword format1
        call [scanf]
        add esp, 4 * 2              ; Se citeste primul numar
        
        push dword mesaj2
        call [printf]
        add esp, 4 * 1              ; Se afiseaza mesajul de citire al celui de-al doilea numar
        
        push dword b
        push dword format2
        call [scanf]
        add esp, 4 * 2              ; Se citeste al doilea numar
        
        mov eax, [a]
        add eax, [b]                ; EAX = a + b
        
        mov bx, 0                   ; BX = numarul de cifre de 1 pe care le contine suma
        mov ecx, 32                 ; repeta se realizeaza de 32 de ori - nr bitilor lui eax
        jecxz final
        
    repeta:
        test eax, 01h               ; testez daca ultimul bit este 1
        jz nu_este_1
        
        inc bx                      ; daca ultimul bit e 1, incrementam bx - numarul de cifre de 1
        
        nu_este_1:
        
            ror eax, 1              ; mutam bitul 1 pe pozitia 0 pentru a-l verifica
        
    loop repeta
        
    final:
        mov [numar], bx
        push dword [numar]
        push dword format3
        call [printf]
        add esp, 4 * 2              ; se afiseaza numarul de biti 1
        
        push    dword 0      
        call    [exit]       
