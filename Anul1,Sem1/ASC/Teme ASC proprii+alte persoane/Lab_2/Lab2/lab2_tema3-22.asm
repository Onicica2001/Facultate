bits 32 

global start        

extern exit    
import exit msvcrt.dll 

; a-word, b-word, c-word, d-word
segment data use32 class=data
     a dw 10
     b dw 20
     c dw 30
     d dw 40
     
;3.22. (b-a)-(c+c+d)
segment code use32 class=code
    start:
        mov ax, [b]  ;AX=b
        sub ax, [a]  ;AX=AX-a=b-a=20-10
        
        mov dx, [c]  ;DX=c
        add dx, [c]  ;DX=DX+c=c+c=30+30
        add dx, [d]  ;DX=DX+d=c+c+d=30+30+40
        
        sub ax, dx   ;AX=AX-DX=(b-a)-(c+c+d)=(20-10)-(30+30+40)=-90
        
    
        push    dword 0      
        call    [exit]   