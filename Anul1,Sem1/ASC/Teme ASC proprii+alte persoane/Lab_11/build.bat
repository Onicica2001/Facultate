nasm -fobj citeste_sir.asm  
nasm -fobj transforma_alfabet.asm
nasm -fobj main.asm
nasm -fobj afiseaza_sir.asm

alink main.obj transforma_alfabet.obj citeste_sir.obj afiseaza_sir.obj -oPE -subsys console -entry start
