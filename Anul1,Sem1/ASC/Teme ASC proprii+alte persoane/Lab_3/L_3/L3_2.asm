bits 32 ; assembling for the 32 bits architecture


global start        


extern exit               
import exit msvcrt.dll    

;a - byte, b - word, c - double word, d - qword - Interpretare cu semn
segment data use32 class=data
        a db 1
        b dw 2
        c dd 3
        d dq 4
        
        x resq 1



;6. c-(d+a)+(b+c)    
segment code use32 class=code
    start:
        ;d+a 
        ;convertim a la qword
        mov eax,0
        mov edx,0
        mov ebx,0
        mov ecx,0
        mov al,[a]
        cbw     ;byte->word
        cwde    ;word->doubleword
        cdq     ;dword->qword
        
        add eax, dword [d]
        adc edx, dword [d+4] ;edx:eax=a+d 
        
        mov [x],eax
        mov [x+4] ,edx ; x= a+d 
        
        ;c-(d+a)
        ;convertim c la qword
        mov eax,[c]
        cdq 
        
        sub eax,dword [x]
        sbb edx,dword [x+4] ;edx:eax=c-(d+a) 
        
        mov [x],eax
        mov [x+4],edx   ;x=c-(d+a)
        
        ;b+c 
        ;convertim b la dword
        mov ax,[b]
        cwd         ;dx:ax=b 
        mov bx, word [c]
        mov cx, word [c+2] ;cx:bx=c 
        
        add ax,bx 
        adc dx,cx ;dx:ax = b+c
        
        push dx
        push ax 
        pop eax ;eax=b+c 
        ;c-(d+a)+(b+c)
        ;convertim b+c la qword
        cdq
        
        add eax,dword [x]
        adc edx dword [x+4] ;edx:eax=c-(d+a)+(b+c)
        
        mov [x],eax
        mov [x+4],edx  ;x=c-(d+a)+(b+c)
        
        
        
    
    
    
    
    
    
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
