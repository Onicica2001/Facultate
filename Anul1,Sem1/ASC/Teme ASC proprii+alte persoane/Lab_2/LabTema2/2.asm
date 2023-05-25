;a,b,c,d - byte
;(a+a)-(c+b+d)
bits 32 
global start        


extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    a db 7
    b db 2
    c db 1
    d db 3
segment code use32 class=code
    start:
    
        ;a+a
        mov al,[a] ;al=a=40
        add al,[a] ;al=al+a=40+40=a+a
        ;c+b
        mov bl,[c] ;bl=c=8
        add bl,[b] ;bl=bl+b=c+b
        ;c+b+d
        add bl,[d] ;bl=bl+d=c+b+d
        ;(a+a)-(c+b+d)
        sub al,bl ;al=al-bl=(a+a)-(c+b+d)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
