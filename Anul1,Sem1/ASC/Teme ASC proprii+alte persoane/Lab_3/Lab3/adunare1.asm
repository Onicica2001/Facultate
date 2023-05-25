bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;a - byte, b - word, c - double word, d - qword - Interpretare fara semn
    
    a db 5
    b dw 1000h
    c dd 1111h
    d dq 1111111111111111h
   ; de calculat c - (d + d + d ) + ( a - b) (ex 7)    
segment code use32 class=code
    start:
        ; de calculat c - (d + d + d ) + ( a - b)
        mov EAX, [c] ; EAX = c 
        ; convesie fara semn de la dword la un qword pentru a putea face scaderea 
        mov EBX, 0 ; EBX:EAX =  c 
        
        mov EDX, [d]
        mov ECX, [d+4]  ; ECX:EDX  = d 
                        ; partea mai semnficiativa e in ECX 
        add EDX,[d]     ; 
        adc ECX,[d+4]   ; ECX:EDX = d + d    ( 64bits + 64bits = 64bits + CF)
        
        ; daca in continuare pot avea carry 
        adc EDX, [d]     ;
        adc ECX, [d+4]   ; ECX:EDX = d + d + d 
        
        ;  c = EBX:EAX - 
     ; d+d+d = ECX:EDX  
        sub EAX, EDX ; Scad partile mai putin semnificative
        sbb EBX, ECX ; Scad cu carry partile mai semnificative
        
        ; EBX:EAX  = c - (d +d + d )
        
        mov EDX, EAX 
        ; EBX:EDX = c - (d + d +d )
        
        ; pregatesc registrul EAX pentru a stoca (a - b)
        mov EAX, 0 
        mov AL, [a] ; AX = AL = a  
        sub AX, [b]; AX = AX - b 
        ; EAX = (a - b) 
        
        ;convertesc dwordul EAX la dword EBX:EAX 
        mov ECX, 0
        ; de calculat ( c - (d + d + d )  + ( a - b)
        ;             EBX:EDX +
        ;             ECX:EAX 
        ;adun partile mai putin semnificative din EBX:EDX si ECX:EAX
        
        add EAX, EDX    ; EAX = EAX + EDX
        adc EBX, ECX ;  EBX = EBX + ECX + CF 
        
        ;rezultatul calcului este in qwordul EBX:EAX 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
