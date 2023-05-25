; a,b,c,d byte  e,f,g,h word: (e + g) * 2 / (a * c) + (h – f) + b * 3
bits 32

global start

extern exit
import exit msvcrt.dll


segment data use32 class=data
        a db 2
        b db 3
        c db 5
        d db 1
        e dw 10
        f dw 7
        g dw 10
        h dw 9
    
segment code use32 class=code
    start:
        
        ; e+g
         
        mov ax, [e]                     ;AX = 0000 0000 0000 1010 b
        add ax, [g]                     ;AX = AX + g = 0000 0000 0001 0100 b
        
        ; (e+g)*2
        
        mov bx, 2                       ;BL = 0000 0010 b
        mul bx                          ;DX = 0000 0000 0000 0000 b AX = 0000 0000 0010 1000 b
        push dx                         ; pune pe stiva partea high din DX:AX
        push ax                         ; pune pe stiva partea low din DX:AX
        pop ebx                         ; pune in EAX continutul stivei
        
        ; a*c 
        
        mov al, [a]                     ;AL = 0000 0010 b
        mov cl, [c]                     ;CL = 0000 0101 b
        mul cl                          ;AX = 0000 0000 0000 1010 b 
        mov cx, ax                      ;CX = 0000 0000 0000 1010 b
        
        ; (e+g)*2/(a*c)
        mov eax, ebx
        div cx                          ;AX = DX:AX / CX = 0000 0000 0000 0100 b
        
        ; h-f
        
        mov dx, [h]                     ;DX = 0000 0000 0000 1001 b
        sub dx, [f]                     ;DX = DX - f = 0000 0000 0000 0010 b
        
        ; (e + g) * 2 / (a * c) + (h – f)
        
        add ax, dx                      ;AX = AX + DX = 0000 0000 0000 0110 b
        mov dx, ax                      ;DX = 0000 0000 0000 0110 b
        
        ; b*3
        mov al, [b]                     ;AL = 0000 0011 b
        mov bl, 3                       ;BL = 0000 0011 b
        mul bl                          ;AX = 0000 1001 b
        
        ; (e + g) * 2 / (a * c) + (h – f) + b * 3
         
        add ax, dx                      ;AX = AX + DX = 0000 0000 0000 1111 b
        
        push dword 0          
        call [exit]           