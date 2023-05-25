bits 32 


global start        


extern exit               
import exit msvcrt.dll    

;a - byte, b - word, c - double word, d - qword - Interpretare fara semn
segment data use32 class=data
    a db 1
    b dw 2
    c dd 3
    d dq 4
    
    x resq 1
    y resw 1
    z resd 1
    
;6. (a+b)-(a+d)+(c-a)

segment code use32 class=code
    start:
        ;a+b
        ;convertim a la word 
        mov al,[a]
        mov ah,0  ;ax=a
        
        add ax,[b]   
        adc ax,[b]  ;ax=a+b 
        
        mov [y],ax   ;salvam in y=a+b
        ;a+d 
        ;convertim a la qword
        mov al,[a]
        push al
        mov eax,0
        mov edx,0 
        pop al;edx:eax=a 
        
        mov ebx, dword [d]
        mov ecx, dword [d+4] ;ecx:ebx=d 
        
        add eax,ebx
        adc edx,ecx ;edx:eax=a+d 
        
        mov [x],eax
        mov [x+4],edx ;x=a+d 
        ;c-a 
        ;convertim a la dw 
        mov al,[a]
        push al
        mov eax,0
        pop al ;eax=a
        
        mov ebx,[c]  ;ebx=c 
        sub ebx, eax ;ebx=c-a
        mov [z],ebx  ;z=c-a
        ;(a+b)-(a+d)   a+b-word, a+d-qword
        ;convertim y=a+b(Word) la qword
        mov eax,0
        mov edx,0
        mov ax, [y]  ;edx:eax=y=a+b 
        
        sub eax, dword [x]
        sbb edx, dword [x+4] ;edx:eax=(a+b)-(a+d)
        ;(a+b)-(a+d)+(c-a)
        ;convertim c-a la qword
        mov ebx,[z] ; ebx=z
        mov ecx,0   ;ecx:ebx=z
        
        add eax,ebx
        adc edx,ecx ;edx:eax=(a+b)-(a+d)+(c-a)
        mov [x],eax
        mov [x+4],edx ;x=(a+b)-(a+d)+(c-a)
       
        push    dword 0      
        call    [exit]       
