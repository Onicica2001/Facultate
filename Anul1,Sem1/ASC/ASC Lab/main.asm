;Se dau trei siruri de caractere. Sa se afiseze cel mai lung sufix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.


bits 32

global start
extern exit, common_suffix, printf, minim
import exit msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data public:
    s1 db "cevaananas", 0
    len1 dd $-s1
    s2 db "albounas", 0
    len2 dd $-s2
    s3 db "frunas", 0
    len3 dd $-s3
    format db "%s", 0
    
segment code use32 class=code public:
start:
    push dword [len1]
    push dword [len2]
    call minim
    add esp, 4*2

    push eax
    mov edx, s1
    add edx, [len1]
    sub edx, eax
    push dword edx
    mov edx, s2
    add edx, [len2]
    sub edx, eax
    push dword s2
    call common_suffix
    add esp, 4*3
    
    push eax
    push dword format
    call [printf]
    add esp, 4*2
    
    push dword [len1]
    push dword [len3]
    call minim
    add esp, 4*2

    push eax
    mov edx, s1
    add edx, [len1]
    sub edx, eax
    push dword edx
    mov edx, s3
    add edx, [len3]
    sub edx, eax
    push dword edx
    call common_suffix
    add esp, 4*3
    
    push eax
    push dword format
    call [printf]
    add esp, 4*2
    
    push dword [len2]
    push dword [len3]
    call minim
    add esp, 4*2
    
    push eax
    mov edx, s2
    add edx, [len2]
    sub edx, eax
    push dword edx
    mov edx, s3
    add edx, [len3]
    sub edx, eax
    push dword edx
    call common_suffix
    add esp, 4*3
    
    push eax
    push dword format
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]