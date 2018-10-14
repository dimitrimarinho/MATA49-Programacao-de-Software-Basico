; Obs: O código deve estar dentro da pasta da biblioteca
%include "asm_io.inc"

; Variáveis inicializadas
segment .data

    msg1 db "Digite o número a ser analisado: ", 0
    msg2 db "Não é primo", 0
    msg3 db "Primo", 0

 ; Variáveis não inicializadas
segment .bss

    quantidadeDivisores resd 1
    numeroDigitado resd 1

; Código do programa
segment .text
        global  asm_main

asm_main:
        ; Imprime a string "Digite o número a ser analisado: "
        mov eax, msg1
        call print_string

        ; Lê um inteiro
        call read_int   ; eax = inteiro do teclado

        ; PS: Lembrando que 0 e 1 não são primos
        CMP eax, 0
        je NOTPRIMO

        ; PS: Lembrando que 0 e 1 não são primos
        CMP eax, 1
        je NOTPRIMO

        ; Move o inteiro lido do teclado para a variável [numeroDigitado]
        mov [numeroDigitado], eax

        ; Estende o sinal do inteiro armazenado em EAX para EDX:EAX (estende o sinal)
        CDQ

        ; Imprime uma nova linha
        call print_nl

        ; Zerando o número de divisores do número a ser analisado, caso seja > 0 (excluindo o número 1 e quando chegar a ele mesmo a divisão para), o número não será primo
        mov ebx, 0

        ; Zera a quantidadeDivisores do número digitado
        mov [quantidadeDivisores], ebx

        ; Colocando 1 no registrador do divisor, o divisor será incrementado no LOOP_DIV
        mov ecx, 1

        ; Incrementando +1 no divisor para realizar verificar a quantidadeDivisores, pois todos os números são divisivéis por 1
        inc ecx

        ; Rótulo do Loop para verificar a quantidade de divisores do número
        LOOP_DIV:

            ; Realizando a divisão (divisor em ecx)
            idiv ecx

            ; Comparação entre o resto da divisão (no registrador edx) e 0, se for divisível o resto é 0
            CMP edx, 0

            ; JE: edx = 0
            je  divisorEncontrado

            ; JNE: edx != 0
            jne next

            ; Se o resto da divisão por 0, o número é divisível pelo divisor, logo quantidadeDivisores++
            divisorEncontrado:

                ; Registrador ebx = 0, na linha 34 e não foi alterado
                inc ebx

                ; Move o contéudo de divisores encontrados que está no registrador ebx para a variável [quantidadeDivisores]
                mov [quantidadeDivisores], ebx

            next:

            ; Incrementa +1 no divisor
            inc ecx

            CMP ecx, [numeroDigitado]

            ; JE: ecx = [numeroDigitado] (se divisor for igual ao número digitado)
            je PRIMO_ORNOT

            ; JNE: ecx != [numeroDigitado] (no caso, ecx < numeroDigitado)
            jne LOOP_DIV                         ; volta pro LOOP para continuar buscando divisores

        PRIMO_ORNOT:

            ; Move zero para ebx para fazer a comparação com a variável [quantidadeDivisores]
            mov ebx, 0

            ; Compara se a quantidade de divisores é 0 (excetuando 1 e o próprio número)
            CMP [quantidadeDivisores], ebx

            ; se for igual a 0, o número é primo
            je  PRIMO

            ; se for diferente de 0 (neste caso, será maior que 0), então o número não é primo
            jne NOTPRIMO

        NOTPRIMO:

            ; Imprime a string "Não é primo"
            mov eax, msg2
            call print_string

            jmp END_PROGRAM

        PRIMO:

            ; Imprime a string "Primo"
            mov eax, msg3
            call print_string

        END_PROGRAM:

        leave
        ret
