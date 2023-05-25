bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b,c-byte; d-doubleword; e-qword
segment data use32 class=data
    a db 3
    b db 4
    c db 2 
    d dd 20
    e dq 50

; 2. 2/(a+b*c-9)+e-d in interpretarea cu semn
segment code use32 class=code
    start:
        
        mov al , [c]
        mov bl , [b]
        
        ;calculez (b*c) 
        imul bl ; ax = al * bl = (b*c)
        
        mov bx , ax ; salvez continutul lui ax in bx pentru a putea realiza conversia lui a in registriul ax 
        ; bx = ax = (b*c)
        mov al , [a]
       
        ;conversia in interpretarea cu semn a lui al in word 
        cbw ; ax = a 
        
        ;calculez (a+b*c)
        add ax , bx ; ax = ax + bx = (a+b*c)
        
        ;calculez (a+b*c-9)
        sub ax , 9 ; ax = ax - 9 = (a+b*c-9)
        
        ;salvez continutul lui ax in bx pentru a putea realiza impartirea in cadrul registrului ax
        mov bx , ax ; bx = ax = (a+b*c-9)
        
        mov ax , 2 
        
        ;conversia in interpretarea cu semn a lui ax in dword
        cwd ; dx:ax = ax = 2 
        
        ;calculez 2/(a+b*c-9)
        idiv bx ; ax:dx / bx = ax (catul impartirii) si ax:dx % bx = dx(restul impartirii)
        ;ax = 2/(a+b*c-9)
        
        ;conversia in interpretarea cu semn a lui ax in dword
        cwd ; dx:ax = ax = 2/(a+b*c-9)
        
        push dx
        push ax 
        pop eax
        ; eax = dx:ax = 2/(a+b*c-9)
        
        ;conversia in interpretarea cu semn a lui eax in qword
        cdq ; edx:eax = 2/(a+b*c-9)
        
        mov ebx , dword [e+0]
        mov ecx , dword [e+4]
        ;ecx:ebx = e 
        
        ;calculez 2/(a+b*c-9)+e
        add eax , ebx 
        adc edx , ecx 
        ;edx:eax = 2/(a+b*c-9)+e
        
        ;salvez rezultatul curent in ecx:ebx pentru a elibera registrul eax unde au loc conversiile in interpretarea cu semn
        mov ebx , eax 
        mov ecx , edx  
        ;ecx:ebx = 2/(a+b*c-9)+e
        
        mov eax , [d]
        
        ;conversia in interpretarea cu semn a lui eax in qword
        cdq ; edx:eax = d 
        
        ;calculez 2/(a+b*c-9)+e-d
        sub ebx , eax 
        sbb ecx , edx 
        ;ebx:ecx = 2/(a+b*c-9)+e-d
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
