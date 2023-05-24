bits 32 
global start        
extern exit, printf             
import exit msvcrt.dll 
import printf msvcrt.dll   
segment data use32 class=data
    s1  db 'ANA,ARE,MERE,EU,NU,MAI,AM'
    len equ $-s1
    s2 db '^^-,^-^,^-^^,--,^^,-^^,--'
    s3 resb len+1
    format db "%s",0
segment code use32 class=code
    start:
        stc
        pushf
        pop eax
        mov ebx,0
        mov ecx,9
        bucla:
            shr eax,1
            rcl ebx,1
            cmp ecx,6
            jle set
            clc
            jmp continuare
            set:
                stc
            continuare:
            jc urmator
            shr eax,1
            urmator:
        loop bucla
        ; mov ecx,len
        ; mov esi,0
        ; cld
        ; lo: 
            ; mov eax,0
            ; mov ebx,0
            ; mov al,[s1+esi]
            ; mov bl,[s2+esi]
            ; cmp al,','
            ; je nexxt
            ; cmp bl,','
            ; je nexxt
            ; push dword esi
            ; push dword ecx
            
            ; push dword eax
            ; push dword ebx
            ; push dword esi
            ; call change
            ; add esp,4*3
            
            ; pop dword ecx
            ; pop dword esi
            ; mov [s3+esi],al
            ; jmp ye
            
            ; nexxt:
            ; mov byte [s3+esi],','
            
            ; ye:
            ; inc esi
            ; loop lo
        
        
        ; push dword s3
        ; push dword format
        ; call [printf]
        ; add esp,4*2

        ; jmp final
    
       ; change:
        ; mov eax,[esp+12]
        ; mov ebx,[esp+8]
        ; mov ecx,[esp+4]
        ; cmp ebx,'-'
        ; je scadere
        ; mov esi,0
        ; sauexclusiv:
            ; mov ebx,0
            ; shr eax,1
            ; rcl ebx,1
            
            ; mov edx,0
            ; shr ecx,1
            ; rcl edx,1
            
            ; cmp ebx,edx
            ; jne next
            ; zero:
               ; push dword 0
               ; inc esi
               ; jmp iarnext
        
            ; next: 
            ; inc esi
            ; push dword 1
            ; jmp iarnext
            
            ; iarnext:
            ; cmp eax,0
            ; jnz sauexclusiv
            
            ; mov ecx,esi
            ; mov eax,0
            ; aflamnr:
                ; pop ebx
                ; shr ebx,1
                ; rcl eax,1
                ; loop aflamnr
            ; ret

        ; jmp final
        ; scadere:
            ; cmp eax,'A'
            ; jne loop1
            ; mov eax,'Z'
            ; loop scadere
            ; loop1:
            ; sub eax,1
            ; loop scadere
         ; ret
     ; final:
        ; ; exit(0)
        ; push    dword 0      ; push the parameter for exit onto the stack
        ; call    [exit]       ; call exit to terminate the program