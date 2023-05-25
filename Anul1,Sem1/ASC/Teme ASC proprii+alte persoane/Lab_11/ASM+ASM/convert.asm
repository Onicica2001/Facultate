bits 32                         
segment code use32 public code
global convert_caracter

convert_caracter:
       sub al , '0' ; se realizeaza conversia de la caracter la cifra
       ret 