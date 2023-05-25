bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit
extern printf 
extern scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll   
import scanf msvcrt.dll          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    backup dd 0 
    rezultat dw 0 
    a dd 0
    m dd 0 
    n dd 0 
    message db "n=" , 0
    format_mesaj_a db "Valoarea pentru a este:" , 0
    format_mesaj_m  db "Valoarea pentru m este:" , 0
    format_mesaj_n db "Valoarea pentru n este:" , 0 
    format_afisare db "Valorile citite sunt: a = %d , m = %d , n = %d" , 0 
    format_rezultat db "Rezultatul problemei este : %d" , 0 
    format db "%d" , 0 
    
; 29 . Se citesc de la tastatura trei numere a, m si n (a: word, 0 <= m, n <= 15, m > n). Sa se izoleze bitii de la m-n ai lui a si sa se afiseze numarul intreg reprezentat de acesti bitii in baza 10.
segment code use32 class=code
    start:
    
        push dword format_mesaj_a
        call [printf]
        add esp , 4  ; se afiseaza pe ecranul mesajul pentru utilizator de introducere a valorii pentru a 
        
        push dword a
        push dword format 
        call [scanf]
        add esp , 4*2 ; se citeste valoarea intreaga pentru a de la tastatura 
        
        push dword format_mesaj_m
        call [printf]
        add esp , 4 ; se afiseaza pe ecranul mesajul pentru utilizator de introducere a valorii pentru m  
        
        push dword m 
        push dword format
        call [scanf]
        add esp , 4*2 ; se citeste valoarea intreaga pentru m de la tastatura 
        
        push dword format_mesaj_n
        call [printf] 
        add esp , 4 ; se afiseaza pe ecranul mesajul pentru utilizator de introducere a valorii pentru n  
        
        push dword n 
        push dword format 
        call [scanf]
        add esp , 4*2 ; se citeste valoarea intreaga pentru n de la tastatura 
        
        push dword [n]
        push dword [m] 
        push dword [a]
        push dword format_afisare
        call [printf]
        add esp , 4*4 ; se afiseaza in consola valorile citite pentru cele 3 variabile - verificare 
        
        xor dx , dx  ; zerorizare dx 
        mov bx , 2   ; se fixeaza valoarea cu care o sa se inmulteasca in bx 
        mov ecx , [m]
        sub ecx , [n]
        add ecx , 1 ; se determina numarul de pasi care o sa il aibe loop-ul adunare_puteri
        
        adunare_puteri: ;loop mare cu numar cunoscut de pasi:m-n+1 care reprezinta numarul de biti care trebuie izolati
        
        mov ax , 1 ; se porneste cu ridicarea de putere de la 1 ca sa aiba sens inmultirea 
        mov [backup] , ecx ; se salveaza continul lui ecx intr-o variabila(ecx - nr. de biti care mai trebuie izolati)
        mov ecx , [n] ; aici , ecx semnifica la a cata putere a lui 2 trebuie sa ridicam 
        
        inc ecx 
        mov [n] , ecx ; se salveaza urmatoarea putere in n
        dec ecx ; se revine cu ecx la pasul curent 
        
        cmp ecx , 0 
        je putere_zero ; daca trebuie sa ridicam la puterea 0 , doar se va sari la eticheta putere_zero unde se adauga 1 la rezultat
        
        ridicare_putere: ; loop care ridica pe 2 la puterea stabilita in registrul ecx 
        
        mul bx 
       
        loop ridicare_putere
        
        putere_zero: ;se adauga la rezultat puterea corespunzatoare a lui 2 , respectiv 1 daca 2 este la puterea 0 
        
        add [rezultat] , ax ; adaugare la rezultatul problemei , in rezultat am retinut valoarea cu care se va realiza AND logic
        mov ecx , [backup]  ; se revine la nr. de pasi din loop-ul principal      
        
        loop adunare_puteri
        
        mov ax , word[a]
        mov bx , [rezultat]
        and ax , bx ; se realizeaza AND logic intre word-ul de la a si rezultatul obtinut prin adunare de puteri ale lui 2(reprezentand biti)
        
        mov bx , ax ; se salveaza in bx , continutul din ax pentru a zeroriza eax 
        xor eax , eax ; zerorizare eax 
        mov ax , bx ; se realizeaza conversie fara semn de la ax la eax , in cazul conversiei cu semn trebuie: cwde
        
        push eax 
        push format_rezultat
        call [printf]
        add esp , 4*2  ; se afiseaza in consola rezultatul problemei
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
