bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    ; ...
    a db 5
    b db 6
    c resd 1

segment code use32 class=code
    start:
        ; 5 - 6
        
        mov eax,0   ;eax = 0
        mov al,[a]  ;al = 5 (eax = 5)
        sub eax,[b] ;eax = 5-6 = -1
        mov [c],eax ;c=-1 
        
        
        push    dword 0   
        call    [exit]     
