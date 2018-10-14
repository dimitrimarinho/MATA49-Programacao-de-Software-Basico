;Obs: O código deve estar dentro da pasta da biblioteca
%include "asm_io.inc"

segment .data   ; Variáveis inicializadas

    msg1 db "Digite o número a ser analisado: ", 0
    msg2 db "Não é primo", 0
    msg3 db "Primo", 0

segment .bss     ; Variáveis não inicializadas

    numeroDigitado resd 1

; Código do programa
segment .text
        global  asm_main

asm_main:

        mov eax, msg1      ; Imprime a string "Digite o número a ser analisado: "
        call print_string

        call read_int      ; Lê um inteiro / eax = inteiro do teclado

        call print_nl      ; Imprime uma nova linha

        CMP eax, 0         ; PS: Lembrando que 0 e 1 não são primos
        je NOTPRIMO

        CMP eax, 1         ; PS: Lembrando que 0 e 1 não são primos
        je NOTPRIMO

        mov [numeroDigitado], eax       ; salvando o número digitado

        mov ebx, eax    ; movendo numero lido para ebx
        sub ebx, 1      ; subtraindo 1 do numero lido
        mov ecx, ebx         ; jogando em ecx para fazer o loop das divisoes

        LOOP_DIV:        ; divisões sucessivas para procurar divisores

            CMP ecx, 1      ; se o divisor for 1 e ele não tiver encontrado outros divisores então o número é primo
            je PRIMO

            CDQ             ; estende o sinal de eax para a divisão (edx:eax)
            idiv ecx        ; divide o numero por ecx
            CMP edx, 0      ; compara se o resto da divisão é 0
            je NOTPRIMO     ; se for 0, o número é divisível logo ele não é primo
            mov eax, [numeroDigitado]   ; eax mudou o valor na divisão, armazenando o quociente, devolvendo o valor do numero digitado para eax
            loop LOOP_DIV   ; ecx = ecx-1;

        NOTPRIMO:

            mov eax, msg2               ; Imprime a string "Não é primo"
            call print_string
            call print_nl               ; Imprime uma nova linha

            jmp END_PROGRAM

        PRIMO:

            mov eax, msg3               ; Imprime a string "Primo"
            call print_string
            call print_nl      ; Imprime uma nova linha

        END_PROGRAM:

        leave
        ret
