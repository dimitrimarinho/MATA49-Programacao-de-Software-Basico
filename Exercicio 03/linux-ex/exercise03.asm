;Obs: O código deve estar dentro da pasta da biblioteca
%include "asm_io.inc"

segment .data   ; Variáveis inicializadas

    msg1 db "Digite o número binário a ser convertido: ", 0
    msg2 db "Representação em decimal: ", 0

segment .bss     ; Variáveis não inicializadas

segment .text    ; Código do programa

        global  asm_main

asm_main:

        mov eax, msg1      ; Imprime a string "Digite o número binário a ser convertido: "
        call print_string

        mov edx, 0        ; numero em decimal
        mov ecx, 8        ; loop , 8 bits a leitura
        lp:
                  call read_char ;le um caractere e guarda em al
                  cmp al, "1"
                  je find1
                  jne find0
                  find1:
                      sal edx, 1    ; acrescenta 0 à esquerda (empurrando)
                      add edx, 1    ; soma +1 no ultimo bit zerado
                      jmp next
                  find0:
                      sal edx, 1    ; acrescenta 0 à esquerda (empurrando)
                  next:
                  loop lp

        call print_nl      ; Imprime uma nova linha
        mov eax, msg2      ; Imprime a string "Representação em decimal: "
        call print_string
        mov eax, edx       ; colocando o binario de edx para imprimir em eax
        call print_int      ; imprime a representação do número em eax 
        call print_nl      ; Imprime uma nova linha


        leave
        ret
