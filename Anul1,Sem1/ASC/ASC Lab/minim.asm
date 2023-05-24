bits 32

global minim

segment code use32 class=code public:
minim:
    mov eax, [esp+4]
    cmp eax, [esp+8]
    jbe final
    mov eax, [esp+8]
    final:
        ret