bits 32
global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

extern cifra

segment data use32 class=data
    n equ 5                      ; nr de numere citite
    s1 resd n
    s2 resd n
    format1 db '%d', 0
    format2 db 'Sirul s2: ', 0
    format3 db '%d ', 0
    format4 db 'introduceti %d numere: ', 0

; 23. Sa se citeasca un sir de numere intregi s1 (reprezentate pe dublucuvinte) in
; baza 10. Sa se determine si sa se afiseze sirul s2 compus din cifrele aflate
; pe poziţia sutelor în fiecare numar intreg din sirul s1.
; Exemplu:
; Sirul s1: 5892, 456, 33, 7, 245
; Sirul s2: 8, 4, 0, 0, 2

segment code use32 class=code
    start:
        push n
        push format4
        call [printf]
        add esp, 4*2

        ; citim n numere
        lea edi, [s1]
        mov ecx, n
        cmp ecx, 0
        je final        
    citire:
        pushad
        push edi
        push format1
        call [scanf]
        add esp, 4*2
        popad
        add edi, 4
        loop citire

        ; salvam cifrele sutelor numerelor citite, incepand de la adresa s2
        lea edi, [s2]
        lea esi, [s1]
        mov ecx, n
        cmp ecx, 0
        je final
        cld
    sir2:
        push ecx                ; pastram valoarea lui ecx pe stiva
        mov eax, [esi]
        push eax                ; punem pe stiva numarul
        call cifra              ; apelam procedura care va pune in eax cifra sutelor
        add esp, 4
        stosd                   ; salvam cifra
        pop ecx
        add esi, 4
        loop sir2

        ; afisam cifrele
        push format2
        call [printf]
        add esp, 4

        lea esi, [s2]
        mov ecx, n
        cmp ecx, 0
        je final
    afisare:
        push ecx                ; pastram valoarea lui ecx pe stiva
        mov eax, [esi]
        push eax                ; punem cifra pe stiva
        push format3
        call [printf]           ; afisam cifra
        add esp, 4*2
        pop ecx
        add esi, 4
        loop afisare

        ; pentru ca programul (consola) sa nu se inchida
        ; lea eax, [s1]
        ; push eax
        ; push format1
        ; call [scanf]
        ; add esp, 4

    final:
        push    dword 0
        call    [exit]
