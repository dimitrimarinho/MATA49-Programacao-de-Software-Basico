; Obs: o código deve estar dentro da pasta da biblioteca
%include "asm_io.inc"

;variaveis inicializadas
segment .data

  msg1 db "Digite o primeiro numero: ", 0
  msg2 db "Digite o segundo numero: ", 0
  msg3 db "Soma: ", 0
  msg4 db "Subtracao: ", 0
  msg5 db "Multiplicacao: ", 0
  msg6 db "Divisao: ", 0
  msg7 db "Resto da divisao: ", 0

; variaveis nao inicializadas
segment .bss

  var resd 1

;codigo do programa
segment .text
        global  asm_main

asm_main:
        ;imprime a string "Digite o primeiro numero: "
        mov eax, msg1
        call print_string

        ;le um inteiro
        call read_int   ;eax = inteiro do teclado

        ;movendo o primeiro inteiro para ebx
        mov ebx, eax

        ;imprime a string "Digite o segundo numero: "
        mov eax, msg2
        call print_string

        ;le um inteiro
        call read_int   ;eax = inteiro do teclado

        ;movendo o segundo inteiro para edx
        mov edx, eax

        ;imprime uma nova linha
        call print_nl

        ;imprime a string "Soma: "
        mov eax, msg3
        call print_string

        ;movendo o conteúdo de ebx para eax
        mov eax, ebx

        ;realizando a soma em eax (eax = eax + edx)
        add eax, edx

        ;imprime o resultado da soma em eax
        call print_int

        ;imprime uma nova linha
        call print_nl

        ;imprime a string "Subtracao: "
        mov eax, msg4
        call print_string

        ;conteudo do primeiro inteiro em ebx joga em eax
        mov eax, ebx

        ;faz primeiro inteiro - segundo inteiro, segundo inteiro esta em edx
        sub eax, edx

        ;imprime o resultado da subtracao em eax
        call print_int

        ;imprime uma nova linha
        call print_nl

        ;imprime a string "Multiplicacao: "
        mov eax, msg5
        call print_string

        ;move o primeiro inteiro para eax
        mov eax, ebx

        ;faz a multiplicação em eax com o segundo inteiro
        imul eax, edx

        ;imprime o resultado da multiplicacao em eax
        call print_int

        ;imprime uma nova linha
        call print_nl

        ;imprime a string "Divisao: "
        mov eax, msg6
        call print_string

        ;movendo o segundo inteiro para ecx
        mov ecx, edx

        ;zerando o resto da divisão
        mov edx, 0

        ;movendo o primeiro inteiro para o dividendo
        mov eax, ebx

        ;estende o sinal do EAX para o EDX
        CDQ

        ;realizando a divisao (divisor em ecx)
        idiv ecx

        ;imprime o resultado da divisao em eax
        call print_int

        ;imprime uma nova linha
        call print_nl

        ;imprime a string "Resto da divisao: "
        mov eax, msg7
        call print_string

        ;movendo resto da divisao em edx para imprimir em eax
        mov eax, edx

        ;imprime o resto da divisao em eax
        call print_int

        ;imprime uma nova linha
        call print_nl

        leave
        ret
