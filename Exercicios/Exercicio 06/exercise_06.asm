; Diretriz de compilação do código: nasm -f elf exercise_06.asm && ld -m elf_i386 -s -o exercise_06 exercise_06.o && ./exercise_06
segment .data

segment .bss

  vetor1 resb 3
  vetor2 resb 3
  enter1 resb 1
  number1 resw 1
  number2 resw 1
  resultado resw 1
  vetor_print3 resw 3
  vetor_print4 resw 4

segment .text

    global _start

_start:

  le_vetor1:        ; Este código lê os primeiros chars e armazena o primeiro número de três dígitos no vetor1
    mov EAX, 3      ; 3 indica ao sistema para executar a leitura
    mov EBX, 0      ; lê da entrada padrão
    mov ECX, vetor1   ; quem deve receber o caractere lido
    mov EDX, 3        ; tamanho da entrada
    int 0x80          ; chamada do kernel do linux

  le_enter_apos_primeiro_numero:    ; Este código lê e ignora o "\n" (enter) após a entrada do primeiro numero
    mov EAX, 3      ; 3 indica ao sistema para executar a leitura
    mov EBX, 0      ; lê da entrada padrão
    mov ECX, enter1   ; quem deve receber o caractere lido
    mov EDX, 1        ; tamanho da entrada
    int 0x80          ; chamada do kernem do linux

  le_vetor2:                        ; Este código lê os chars e armazena o segundo número de três dígitos no vetor2
    mov EAX, 3      ; 3 indica ao sistema para executar a leitura
    mov EBX, 0      ; lê da entrada padrão
    mov ECX, vetor2   ; quem deve receber o caractere lido
    mov EDX, 3        ; tamanho da entrada
    int 0x80

  converte_vetor1_para_inteiro:     ; Este código converte o primeiro número do vetor para inteiro
    mov EDX, 0
    mov [number1], EDX
    convertendo_number1:
              mov AL, [vetor1 + 0]     ; movendo conteudo da primeira casa do vetor para AL
              sub AL, 48      ; na tabela ASCII, '0' é 48 em decimal
              mov DL, 100     ; movendo 100 para DL para multiplicação
              imul DL        ;  AX = AL * DL
              add [number1], AX    ; adicionando na variável number1 para transformar no número
              mov AL, [vetor1 + 1] ; movendo conteudo da segunda casa do vetor para AL
              sub AL, 48            ; na tabela ASCII, '0' é 48 em decimal
              mov DL, 10            ; movendo 10 para DL para multiplicação
              imul DL               ; AX = AL * DL
              add [number1], AX
              mov AL, [vetor1 + 2] ; movendo conteudo da terceira casa do vetor para AL
              sub AL, 48        ; na tabela ASCII, '0' é 48 em decimal
              add [number1], AL

  converte_vetor2_para_inteiro:     ; Este código converte o segundo número do vetor para inteiro
       mov EDX, 0
       mov [number2], EDX
       convertendo_number2:
              mov AL, [vetor2 + 0]     ; movendo conteudo da primeira casa do vetor para AL
              sub AL, 48      ; na tabela ASCII, '0' é 48 em decimal
              mov DL, 100     ; movendo 100 para DL para multiplicação
              imul DL        ;  AX = AL * DL
              add [number2], AX    ; adicionando na variável number1 para transformar no número
              mov AL, [vetor2 + 1] ; movendo conteudo da segunda casa do vetor para AL
              sub AL, 48            ; na tabela ASCII, '0' é 48 em decimal
              mov DL, 10            ; movendo 10 para DL para multiplicação
              imul DL               ; AX = AL * DL
              add [number2], AX
              mov AL, [vetor2 + 2] ; movendo conteudo da terceira casa do vetor para AL
              sub AL, 48        ; na tabela ASCII, '0' é 48 em decimal
              add [number2], AL

  soma_os_dois_numeros:             ; Este código realiza a soma dos dois números inteiros
       mov EAX, 0            ; zerando AX
       add AX, [number1]      ; AX = number1
       add AX, [number2]      ; AX = number1 + number2

  transforma_numero_em_vetor_para_impressao:    ; Este código pega o resultado final em inteiro e transforma em vetor para impressão
      mov [resultado], AX
      mov BX, 1000
      mov DX, 0
      cwd ; estender AX para DX:AX
      idiv BX
      cmp AX, 1
      je resultado_em_4_casas
      jne resultado_em_3_casas
      resultado_em_4_casas:
        add AX, 48
        mov [vetor_print4], AX
        sub AX, 48
        mov AX, [resultado]
        mov CX, 1000
        sub AX, CX
        mov BX, 100
        mov DX, 0
        idiv BX
        add AX, 48
        mov [vetor_print4 + 1], AX
        sub AX, 48
        mov DX, 100
        imul AX, DX ; AX = AX * 100
        add CX, AX
        mov AX, [resultado]
        sub AX, CX
        mov BX, 10
        mov DX, 0
        idiv BX
        add AX, 48
        mov [vetor_print4 + 2], AX
        sub AX, 48
        mov DX, 10
        imul AX, DX ; AX = AX * 10
        add CX, AX
        mov AX, [resultado]
        sub AX, CX
        add AX, 48
        mov [vetor_print4 + 3], AX
        jmp imprime_vetor_4_casas_com_interrupcao

      resultado_em_3_casas:
          mov CX, 0
          mov AX, [resultado]
          mov BX, 100
          mov DX, 0
          idiv BX
          add AX, 48
          mov [vetor_print3], AX
          sub AX, 48
          mov DX, 100
          imul AX, DX ; AX = AX * 100
          add CX, AX
          mov AX, [resultado]
          sub AX, CX
          mov BX, 10
          mov DX, 0
          idiv BX
          add AX, 48
          mov [vetor_print3 + 1], AX
          sub AX, 48
          mov DX, 10
          imul AX, DX ; AX = AX * 10
          add CX, AX
          mov AX, [resultado]
          sub AX, CX
          add AX, 48
          mov [vetor_print3 + 2], AX
          sub AX, 48
          jmp imprime_vetor_3_casas_com_interrupcao

  imprime_vetor_3_casas_com_interrupcao:        ; Este código imprime a soma (com 3 casas) transformado em vetor
        mov eax, 4      ; sys_write()
        mov ebx, 1      ; ... to STDOUT
        mov ecx, vetor_print3 ; ... using the following memory address
        mov edx, 3      ; ... and only print one character
        int 80h         ; SYSCALL
        jmp finalizar_programa

  imprime_vetor_4_casas_com_interrupcao:        ; Este código imprime a soma (com 4 casas) transformado em vetor
         mov eax, 4      ; sys_write()
         mov ebx, 1      ; ... to STDOUT
         mov ecx, vetor_print4 ; ... using the following memory address
         mov edx, 4      ; ... and only print one character
         int 80h         ; SYSCALL

  finalizar_programa:   ; Este código finaliza o programa através do uso de interrupção
      mov edx, 10
      mov [enter1], edx
      ; Imprimir quebra de linha
      mov eax, 4      ; sys_write()
      mov ebx, 1      ; ... to STDOUT
      mov ecx, enter1 ; ... using the following memory address
      mov edx, 1      ; ... and only print one character
      int 80h         ; SYSCALL
      ; System exit
      mov eax,1
      mov ebx,0
      int 80h
