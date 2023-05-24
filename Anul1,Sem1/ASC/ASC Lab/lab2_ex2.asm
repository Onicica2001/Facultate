bits 32 


global start        


extern exit              
import exit msvcrt.dll   
                          

segment data use32 class=data
    d db 50
    a db 12
    b db 16
    c db 20
segment code use32 class=code
    start:
        mov eax,0
        
        ;calculam (a+b)
        mov al,[a]    
        add al,[b]     
        
        ;calculam d-(a+b)
        mov dl,al
        mov al,[d]
        sub al,dl
        
        ;calculam d-(a+b)+c
        add al,[c]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
