bits 32 

global start        

extern exit, printf, scanf
import exit msvcrt.dll  
import printf msvcrt.dll  
import scanf msvcrt.dll  
extern citeste_sir
extern transform
extern afiseaza_sir

;Sa se citeasca un sir s1 (care contine doar litere mici). Folosind un alfabet (definit in segmentul de date), determinati si afisati sirul s2 obtinut prin substituirea fiecarei litere a sirului s1 cu litera corespunzatoare din alfabetul dat.
; ; Exemplu:
; Alfabetul: OPQRSTUVWXYZABCDEFGHIJKLMN
; Sirul s1:  anaaremere
; Sirul s2:  OBOOFSASFS
segment data use32 class=data
    ; ...
    alfabet db "OPQRSTUVWXYZABCDEFGHIJKLMN", 0
    index db 0
    s1 resb 100
    s2 resb 100
    format_w db "Introduceti un sir: ", 0
    format_r db "%s", 0
    f db "Sirul este: %s", 0

segment code use32 class=code
    start:
        push dword s1
        call citeste_sir
        
        push dword alfabet
        push dword s2
        push dword s1
        call transform
    
        push dword s2
        call afiseaza_sir
    
        push    dword 0     
        call    [exit]       
