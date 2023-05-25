bits 32

global inverseaza_cuvinte

extern exit
import exit msvcrt.dll
extern printf
import printf msvcrt.dll

segment data use32 class=data
    
segment code use32 class=code
cauta_capat_cuvant:
    push ebp
    mov ebp, esp
    mov esi, [esp+8]

  continue_search:
    lodsb

    cmp al, 'z'
    ja stop_search

    cmp al, 'a'
    jae continue_search

    cmp al, 'Z'
    ja stop_search

    cmp al, 'A'
    jae continue_search

  stop_search:

    lea eax, [esi-1]
    pop ebp
    ret



inverseaza_cuvant:
    push ebp
    mov ebp, esp

    push dword [esp+8]    
    call cauta_capat_cuvant
    add esp, 4
   
    mov edx, eax

    mov ecx, eax 
    mov esi, [esp+8]
    mov ebx, ecx
    sub ecx, esi
    shr ecx, 1

  inverseaza:
    lodsb   
    xchg al, [ebx-1]
    xchg al, [esi-1]
    dec ebx
    loop inverseaza
        
    mov eax, edx
    pop ebp
    ret

inverseaza_cuvinte:
    push ebp
    mov ebp, esp

    mov esi, [esp+8]

  continue_search2:
    lodsb

    test al, 0xFF
    jz stop_func

    cmp al, 'z'
    ja continue_search2

    cmp al, 'a'
    jae stop_search2

    cmp al, 'Z'
    ja continue_search2
    
    cmp al, 'A'
    jb continue_search2 
   
  stop_search2:

    dec esi
    push esi
    call inverseaza_cuvant
    add esp, 4
    mov esi, eax

    jmp continue_search2

  stop_func:

    pop ebp
    ret
