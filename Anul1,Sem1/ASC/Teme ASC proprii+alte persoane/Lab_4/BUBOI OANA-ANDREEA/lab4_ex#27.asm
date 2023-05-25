bits 32 


global start        


extern exit               
import exit msvcrt.dll    

;Se da quadwordul A. Sa se obtina numarul intreg N reprezentat de bitii 35-37 ai lui A. Sa se obtina apoi in B dublucuvantul rezultat prin rotirea spre dreapta a dublucuvantului inferior al lui A cu N pozitii. Sa se obtina octetul C astfel:
;bitii 0-3 ai lui C sunt bitii 8-11 ai lui B
;bitii 4-7 ai lui C sunt bitii 16-19 ai lui B
segment data use32 class=data
    a dq 0111011101010111100110111011111001110111010101111001101110111110b
    b dd 0
    c db 0
    n db 0


segment code use32 class=code
    start:
        ;Sa se obtina numarul intreg N reprezentat de bitii 35-37 ai lui A
        mov al,byte [a+4]   ;AL=10111110b
        and al,00111000b    ;izolam bitii 35-37 ai lui A
        rol al,3            ;AL=11100000b
        sar al,5            ;AL=11111111b
        mov [n],al          ;N=11111111b
        
        ;Sa se obtina apoi in B dublucuvantul rezultat prin rotirea spre dreapta a dublucuvantului inferior al lui A cu N pozitii
        mov eax,dword [a]   ;EAX=01110111010101111001101110111110b
        mov cl,[n]          ;CL=N=11111111b
        ror eax,cl          ;EAX se roteste spre dreapta cu N pozitii
        mov [b],eax         ;B=11011101010111100110111011111001b
        
        ;Sa se obtina octetul C astfel:
        ;bitii 0-3 ai lui C sunt bitii 8-11 ai lui B
        mov al,byte [b+1]   ;AL=01101110b
        and al,00001111b    ;izolam bitii 8-11 ai lui B
        mov bl,al           ;BL=00001110b
        
        ;bitii 4-7 ai lui C sunt bitii 16-19 ai lui B
        mov al,byte [b+2]   ;AL=01011110b
        and al,00001111b    ;izolam bitii 16-19 ai lui B
        rol al,4            ;AL se roteste spre stanga cu 4 pozitii
        or bl,al            ;punem bitii in rezultat
        mov [c],bl          ;C=11101110b
        
        
    
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
