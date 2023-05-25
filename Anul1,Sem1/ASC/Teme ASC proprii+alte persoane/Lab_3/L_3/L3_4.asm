bits 32 ; assembling for the 32 bits architecture


global start        


extern exit               
import exit msvcrt.dll    
                          

;a,b,d-byte; c-word; e-doubleword; x-qword
segment data use32 class=data
    ; ...
    a db 1
    b db 2
    c dw 3
    d db 4
    e dd 5
    x dq 6
    
    y resq 1

;6. x+a/b+c*d-b/c+e   cu semn 
segment code use32 class=code
    start:
        ;a/b 
        ;convertim a la word
        mov al, [a]
        cbw 
        
        idiv [c] ;al=a/b ah=a%b 
        
        ;x+a/b 
        ;convertim a/b la qword
        cbw 
        cwde
        cdq ;edx:eax=a/b 
        add eax, dword[x]
        adc edx, dword[x+4] ;edx:eax=x+a/b 
        
        mov [y], eax
        mov [y+4], edx ;y=x+a/b 
        
        ;c*d 
        ;convertim c la dword
        mov ax,[c]
        cwd ;dx:ax=c 
        
        imul dword [d] ;edx:eax=c*d 
        
        ;x+a/b+c*d 
        add eax,[y]
        adc edx,[y+4] ;edx:eax=x+a/b+c*d 
        
        mov [y],eax
        mov [y+4],edx ;y=x+a/b+c*d
        
        ;b/c 
        ;convertim b la dword
        mov al,[b]
        cbw 
        cwd ;dx:ax=b 
        
        idiv word [c]; ax=b/c 
        
        ;x+a/b+c*d-b/c 
        ;convertim b/c la qword
        cwde 
        cdq   ;edx:eax=b/c 
        
        mov ebx,[y]
        mov ecx,[y+4]   ;ecx:ebx=x+a/b+c*d 
        
        sub ebx,eax
        sbb ecx,edx ;ecx:ebx=x+a/b+c*d-b/c  
        
        mov [x],ebx
        mov [x+4],ecx
        
        ;x+a/b+c*d-b/c+e 
        ;convertim e la qword
        mov eax,[e]
        cdq     ;edx:eax=e
        
        add eax,[y]
        adc edx,[y+4]   ;edx:eax=x+a/b+c*d-b/c+e 
        
        mov [y],eax
        mov [y+4],edx  ;y=x+a/b+c*d-b/c+e 
        
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
