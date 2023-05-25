bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; OPERATII CU FISIERE TEXT
; 8. Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine litera mare (uppercase) cu cea mai mare frecventa si sa se afiseze acea litera, impreuna cu frecventa acesteia. Numele fisierului text este definit in segmentul de date.
segment data use32 class=data
    nume_fisier db "TemaASC10.txt", 0      ; numele fisierului care va fi deschis
    mod_acces db "r", 0                    ; modul de deschidere a fisierului - 
                                           ; r - pentru scriere. fisierul trebuie sa existe 
    descriptor_fis dd -1                   ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    sir resb 1                             ; sirul in care se va citi textul din fisier 
    frecvente resb 'Z'-'A' + 1
    max resd 1
    poz resd 1
    format db "Litera uppercase %c apare de %d ori.", 0

; our code starts here
segment code use32 class=code
start:
        ; apelam fopen pentru a deschide fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
  push dword mod_acces     
  push dword nume_fisier
  call [fopen]
  add esp, 4*2                        ; eliberam parametrii de pe stiva

  mov [descriptor_fis], eax           ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
  cmp eax, 0
  je final
        
        ; citim fiecare caracter in fisierul deschis folosind functia fread
        ; eax = fread(text, 1, 1, descriptor_fis)
  citire:
    push dword [descriptor_fis]
    push dword 1
    push dword 1
    push dword sir
    call [fread]
    add esp, 4*4                        ; dupa apelul functiei fread EAX contine numarul de caractere citite din fisier
    
    cmp eax, 0
    je afisare
    
    ;cautam literele uppercase
    mov eax, 0
    mov al, [sir]
    cmp al, 'A'
    jb urmatorul
    cmp al, 'Z'
    ja urmatorul
    
    sub al, 'A'
    add [frecvente + eax], byte 1
    
    urmatorul:
        jmp citire
        
        ; vom parcurge sirul de frecvente si vom determina litera cu cea mai mare frecventa
        ; frecventa va fi salvata in variabila max, iar pozitia literei corespunatoare in variabila poz     
  afisare:
    mov ecx, 'Z'-'A' + 1
    mov esi, frecvente
    maxim:
        lodsb
        cmp al, byte [max]
        jb maiCauta
        mov byte [max], al
        mov edx, esi
        sub edx, frecvente
        dec edx
        mov byte [poz], dl
        maiCauta:
            loop maxim
            
    mov eax, 'A'
    add eax, [poz]
    
    ;printf("Litera uppercase %c apare de %d ori.", eax, max)
    push dword [max]
    push dword eax
    push dword format
    call [printf]
    add esp, 4*3
  
  ; apelam functia fclose pentru a inchide fisierul
  ; fclose(descriptor_fis)
  push dword [descriptor_fis]
  call [fclose]
  add esp, 4*1
    
  final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program