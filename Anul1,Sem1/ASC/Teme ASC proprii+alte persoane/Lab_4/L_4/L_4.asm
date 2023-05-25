bits 32 ; assembling for the 32 bits architecture


global start        


extern exit               
import exit msvcrt.dll    
                          

;25. Se dau 2 dublucuvinte M si N. Sa se obtina dublucuvantul P astfel:
;     bitii 0-6 din P coincid cu bitii 10-16 a lui M
;     bitii 7-20 din P concid cu bitii obtinuti 7-20 in urma aplicarii M AND N.
;     bitii 21-31 din P coincid cu bitii 1-11 a lui N.
segment data use32 class=data
    m dd 12345678h
    n dd 87654321h
    p dd 0


segment code use32 class=code
    start:
    
        mov ebx, 0 ; in ebx calculam rezultatul
        mov eax, [m]
        and eax, 0000 0000 0000 0001 1111 1100 0000 0000b
        mov cl, 10
        ror eax,cl ;rotim 10 pozitii spre dreapta
        or ebx, eax ; punem bitii in rezultat
        
        mov eax, [m] 
        and eax, 87654321h ;eax=m and n
        and eax, 0000 0000 0001 1111 1111 1111 1000 0000b ;izolam bitii 7-20
        or ebx,eax ; punem bitii in rezultat
        
        mov eax, [n]
        and eax, 0000 0000 0000 0000 0000 1111 1111 1110b
        mov cl, 20
        rol eax, cl ; rotim spre stanga 
        or ebx, eax ;punem bitii in rezultat
        
        mov [p],ebx ;punem valoarea din registru in variabila rezultat
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
