bits 32 ; assembling for the 32 bits architecture

extern _printf 

global _asmC
           
segment data use32 class=data
    adresaSirRezultat1 dd 0
    adresaSirRezultat2 dd 0
segment code use32 class=code

_asmC:
   ;Codul de intrare
    ; creare cadru de stiva pentru programul apelat
    push ebp
    mov ebp, esp
    sub esp,4*4
    
   ;Codul de apel
    ; la locatia [ebp] se afla valoarea ebp pentru apelant
    ; la locatia [ebp+4] se afla adresa de return (valoarea din EIP la momentul apelului)
    ; la locatia [ebp+6] se afla adresa sirului 1
    ; la locatia [ebp+12] se afla adresa sirului 2
    ; la locatia [ebp+16] se afla adresa sirului rezultat
    cld
    mov esi, [ebp+12]
    mov edi, [ebp+16]
    
    lodsb
    start:
        cmp al,'0'
        jb next
        cmp al,'9'
        ja next
        stosb
        next:
          lodsb
          cmp al,0
          jne start
    mov esi,[ebp+8]
    start2:
        cmp al,'0'
        jb next2
        cmp al,'9'
        ja next2
        stosb
        next2:
          lodsb
          cmp al,0
          jne start2
    
   ;Codul de iesire
    add esp, 4 * 4
   
    mov esp, ebp
    pop ebp
    ret
  
