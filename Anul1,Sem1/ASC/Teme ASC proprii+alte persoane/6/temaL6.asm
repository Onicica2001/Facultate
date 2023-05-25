bits 32
global start        

extern exit               
import exit msvcrt.dll   

;Se da un sir de dublucuvinte. Sa se ordoneze descrescator sirul cuvintelor inferioare ale acestor dublucuvinte. Cuvintele superioare raman neschimbate.
;rezultat: 1234ABCDh, 12565678h, 12AB4344h.
segment data use32 class=data
    sir DD 12345678h, 1256ABCDh, 12AB4344h
    len equ $ - sir  ; lungimea sirului sir
    
segment code use32 class=code
    start:
        cld
        mov esi, sir
        
        mov ecx, len
        dec ecx                         ; 0 <= i < len-1
        
        repeta:
            push ecx
            
            lodsw
            add esi,2
            push esi
            
            sub esi,4
            
            mov ebx, 4                  ; j = i+1
            repeta2:
                mov dx, [esi + ebx]
                
                cmp ax, dx
                ja sari
                
                
                ; interschimb ax cu dx
                mov edi, esi    
                add edi, ebx
                movsw
                dec esi
                dec esi
                
                mov ax, dx     
                mov edi, esi
                stosw
                
             sari:
                add ebx,4
                cmp ebx, len
                je sari2 
                
            loop repeta2

          sari2:
            pop esi
            pop ecx
        loop repeta
    
        ; exit(0)
        push dword 0                   
        call [exit]    