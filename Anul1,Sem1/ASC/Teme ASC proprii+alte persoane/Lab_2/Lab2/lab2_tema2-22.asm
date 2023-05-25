bits 32 

global start        

extern exit    
import exit msvcrt.dll 

; a-byte, b-byte, c-byte, d-byte
segment data use32 class=data
     a dw 4
     b db 3
     c db 2
     d db 1
     
;2.22. (a+b+b)-(c+d)
segment code use32 class=code
    start:
        mov al, [a]  ;AL=a=4
        add al, [b]  ;AL=AL+b=a+b=4+3
        add al, [b]  ;AL=AL+b=a+b+b=4+3+3
        
        mov ah, [c]  ;AH=c=2
        add ah, [d]  ;AH=AH+d=c+d=2+1
        
        sub al, ah   ;AL=AL-AH=(a+b+b)-(c+d)=(4+3+3)-(2+1)=7
    
        push    dword 0      
        call    [exit]   