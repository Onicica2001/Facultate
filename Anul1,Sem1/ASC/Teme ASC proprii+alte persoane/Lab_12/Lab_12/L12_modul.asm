bits 32


global _transformare

; linkeditorul poate folosi segmentul public de date si pentru date din afara
segment data public data use32
; codul scris in asamblare este dispus intr-un segment public, posibil a fi partajat cu alt cod extern
segment code public code use32

;sum=a%10+(a/10%10)*2+(a/100%10)*4+(a/1000)*8;
;a=1234
_transformare:
    push ebp
    mov ebp, esp
    mov ebx,0 ;ebx=suma
    ; ebp+8 =a   ebp+4 -> adr de reintoarcere 
    mov eax, [ebp+8] ;ebx=a 
    cdq
    mov ecx,10
    div ecx
    ;edx = a%10
    add ebx,edx ;ebx = a%10 =4
    ;eax = a/10 =123
    cdq
    mov ecx,10
    div ecx
    ;edx=a/10%10=3
    ;eax=a/100
    push eax
    mov eax,edx ;eax = a/10%10 =3
    mov cl,2
    mul cl
    ;ax = 2*3
    cwde
    add ebx,eax
    pop eax
    ;eax=a/100 = 12
    cdq
    mov ecx,10
    div ecx
    ;edx=a/100%10
    ;eax=a/1000
    push eax
    mov eax,edx ;eax = a/100%10 =2
    mov cl,4
    mul cl
    ;ax = 2*4
    cwde
    add ebx,eax
    pop eax
    ;eax=a/1000
    mov cl,8
    mul cl
    cwde 
    add ebx,eax
    mov eax,ebx
    
    mov esp,ebp
    pop ebp
    ret 
    
    
    
    
