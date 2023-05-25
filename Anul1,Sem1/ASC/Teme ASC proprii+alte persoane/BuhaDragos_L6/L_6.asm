bits 32 ; assembling for the 32 bits architecture


global start        


extern exit               
import exit msvcrt.dll    
                          

;Se da un sir A de dublucuvinte. Cunstruiti doua siruri de octeti  
; - B1: contine ca elemente partea inferioara a cuvintelor inferioara din A
; - B2: contine ca elemente partea superioara a cuvintelor superioare din A

segment data use32 class=data
    A dd 11223344h, 55667788h, 12345678h,123abcdeh
    len equ ($-A)/4
    B1 times len db 0
    B2 times len db 0


segment code use32 class=code
    start:
        mov esi, A
        mov edi, B1 ;in edi punem adresa la care incepe B1 
        cld   ;parcurgere stanga->dreapta
        mov ecx, len
        repeta:
                lodsw ;in ax vom avea cuv inferior  
                ;shl ax,8
                ;mov al, 0 ;parte inferioara 
                ;mov ah,0 ;al partea inferioara 
                stosb ;punem partea inferioara a cuv din ax
                lodsw ;trecem peste cuv superior 
        loop repeta ;(ecx--) cat timp ecx>0
        
        mov esi,A
        mov edi,B2 ;punem in edi adresa la care incepe B2 
        cld ;parcurgere stanga->dreapta
        mov ecx,len
        repeta2:
                lodsw ;in ax vom avea cuv inferior
                lodsw; in ax vom avea cuv superior
                shr ax,8 ;al partea superioara 
                ;mov ah,0 ;ax parte superioara
                stosb
        loop repeta2
                
    
        push    dword 0     
        call    [exit]       
