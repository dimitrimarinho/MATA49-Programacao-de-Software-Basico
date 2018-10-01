;Obs: O código deve estar dentro da pasta da biblioteca
%include "asm_io.inc"

segment .data   ; Variáveis inicializadas

    espaco db " ", 0

segment .bss     ; Variáveis não inicializadas

    vetor1 resd 10
    vetor2 resd 10
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

        mov ebx, 0          ; posicao do vetor
        mov ecx, 10         ; contagem do loop, numero de posicoes
        lp_addvetor2:
            call read_int
            mov [vetor2+ebx], eax
            add ebx, 4
            loop lp_addvetor2


        mov ebx, 0
        mov edx, 0
        mov ecx, 100

        compare:
            cmp edx, 40
            je finish
            mov eax, [vetor2+edx]
            cmp [vetor1+ebx], eax
            je  printnumber
            jne finding
            printnumber:
              call print_int      ; imprime a representação do número em eax
              mov eax, espaco
              call print_string
              jmp found_nextloop
            finding:
              add ebx, 4
              loop compare
            found_nextloop:
              add edx, 4
              mov ebx, 0
              loop compare

          finish:
            call print_nl      ; Imprime uma nova linha
            leave
            ret
