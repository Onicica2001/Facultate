bits 32 

global start        

extern exit    
import exit msvcrt.dll 

; a-byte, b-byte, c-byte, d-word
segment data use32 class=data
     a db 10
     b db 20
     c db 30
     d dw 80
     
;4.22. [(10+d)-(a*a-2*b)]/c
segment code use32 class=code
    start:
        mov ax, 10    ;AX=10
        add ax, [d]   ;AX=AX+d=10+80
        
        mov dl, [a]   ;DL=a=10
        mul byte [a]  ;DX=DL*a=10*10
        
        mov bl, 2     ;BL=2
        mul byte [b]  ;BX=BL*b=2*20
        
        sub dx, bx    ;DX=DX-BX=a*a-2*b=10*10-2*20
        
        sub ax, dx    ;AX=AX-DX=(10+d)-(a*a-2*b)=(10+80)-(10*10-2*20)
        
        div byte [c]  ;AL=AX/c=[(10+d)-(a*a-2*b)]/c=1
        
        push    dword 0      
        call    [exit]   