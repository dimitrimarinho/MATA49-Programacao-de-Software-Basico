;Obs: O código deve estar dentro da pasta da biblioteca
%include "asm_io.inc"

segment .data   ; Variáveis inicializadas

    espaco db " ", 0

segment .bss     ; Variáveis não inicializadas

    vetor1 resd 10
    numberfound resd 1

segment .text    ; Código do programa

        global  asm_main

asm_main:

      mov ebx, 0          ; posicao do vetor
      mov ecx, 10         ; contagem do loop, numero de posicoes
      lp_addvetor1:
          call read_int
          mov [vetor1+ebx], eax
          add ebx, 4
          loop lp_addvetor1

      mov ebx, 0
      mov ecx, 100
      mov edx, 1        ; read 1 integer
      call read_int     ; eax = int
      compare:

          cmp edx, 10
          je finish
          cmp ebx, 40
          je readinteger
          cmp eax, [vetor1+ebx]
          jne addebx
          je  found

          addebx:
            add ebx, 4
            loop compare

          found:
            call print_int      ; imprime a representação do número em eax
            mov eax, espaco
            call print_string
            inc edx           ; read+1 integer
            call read_int     ; eax = int
            mov ebx, 0
            loop compare
            
          readinteger:
            call read_int     ; eax = int
            inc edx
            mov ebx, 0
            loop compare

          finish:
            call print_nl      ; Imprime uma nova linha
            leave
            ret
