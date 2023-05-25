bits 32                         

global modul

extern printf
import printf msvcrt.dll

segment data use32 class=data
    mesaj1 db "Nr pozitive: ",0
    mesaj2 db "Nr negative: ",0
    mesaj3 db 10,0
    format1 db "%s",0
    format db "%d ",0
    
segment code use32 class=code
    modul:
        push dword mesaj1
        push dword format1
        call [printf]
        add esp,4*2
        
        mov esi,[esp+12]
        mov eax ,[esp+16]
        cdq
        mov ebx, 4
        div ebx
        mov ebx, eax
       afisare_pozitive:
        lodsd
        push eax
        push dword format
        call [printf]
        add esp,4*2
        dec ebx
        cmp ebx, 0
        jne afisare_pozitive
        
        push dword mesaj3
        call [printf]
        add esp,4
       
        push dword mesaj2
        push dword format1
        call [printf]
        add esp,4*2
      
        mov esi,[esp+4]
        mov eax ,[esp+8]
        cdq
        mov ebx, 4
        div ebx
        mov ebx, eax

       afisare_negative:
        lodsd
        push eax
        push dword format
        call [printf]
        add esp, 4*2
        dec ebx
        cmp ebx, 0
        jne afisare_negative
        ret