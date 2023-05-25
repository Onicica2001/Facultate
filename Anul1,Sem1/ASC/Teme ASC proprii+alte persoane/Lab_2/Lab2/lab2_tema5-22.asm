bits 32 

global start        

extern exit    
import exit msvcrt.dll 

; a-byte, b-byte, c-byte
segment data use32 class=data
     a db 10
     b db 30
     c db 20
     
;5.22. (a+(b-c))*3
segment code use32 class=code
    start:
        mov al, [b]   ;AL=b=20
        sub al, [c]   ;AL=AL-c=b-c=30-20
        
        add al, [a]   ;AL=AL+a=a+(b-c)
        
        mov ah, 3     ;AH=3
        mul ah        ;AX=AL*AH=(a+(b-c))*3=60
        
        push    dword 0      
        call    [exit]