bits 32 

global start        

extern exit    
import exit msvcrt.dll 

segment data use32 class=data
    
;1.22. 16/4
segment code use32 class=code
    start:
        mov ax, 16  ;AX=16
        mov bl, 4   ;BL=4
        div bl      ;AL=AX/BL=16/4=4 si AH=AX%BL=16%4=0
    
        push    dword 0      
        call    [exit]   