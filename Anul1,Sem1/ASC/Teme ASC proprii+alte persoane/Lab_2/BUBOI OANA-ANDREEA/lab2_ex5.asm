bits 32 


global start        


extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    a db 21
    c db 17
    d db 14
    f dw 100h

segment code use32 class=code
    start:
        mov eax,0   
        ;calculam c-2
        mov al,[c]  
        sub al,2    
        mov dl,al   
        ;calculam 3+a
        mov al,3    
        add al,[a]  
        ;calculam (c-2)*(3+a)
        mul dl      
        mov dx,ax   
        ;calculam d-4
        mov al,[d]  
        sub al,4    
        mov bl,al   
        ;calculam (c-2)*(3+a)/(d-4)
        mov ax,dx   
        div bl      
        ;calculam f+(c-2)*(3+a)/(d-4)
        mov ah,0
        add ax,[f]  
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
