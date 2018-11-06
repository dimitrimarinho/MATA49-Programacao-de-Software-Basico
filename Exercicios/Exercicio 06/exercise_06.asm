; nasm -f elf exercise_06.asm && ld -m elf_i386 -s -o exercise_06 exercise_06.o
segment .data

segment .bss ; leitura dos caracteres dos números

  vetor1 resb 3
  vetor2 resb 3
  enter1 resb 1
  divisor resd 1
  number1 resb 1
  number2 resb 1
  resultado resd 1
  vetor_print resb 4

segment .text

  global _start

_start:

  mov EAX, 3      ; 3 indica ao sistema para executar a leitura
  mov EBX, 0      ; lê da entrada padrão
  mov ECX, vetor1   ; quem deve receber o caractere lido
  mov EDX, 3        ; tamanho da entrada
  int 0x80          ; chamada do kernel do linux

  ; esse código aqui é para ler o \n da entrada do primeiro numero
  mov EAX, 3      ; 3 indica ao sistema para executar a leitura
  mov EBX, 0      ; lê da entrada padrão
  mov ECX, "\n"   ; quem deve receber o caractere lido
  mov EDX, 1        ; tamanho da entrada
  int 0x80          ; chamada do kernem do linux

  mov EAX, 3      ; 3 indica ao sistema para executar a leitura
  mov EBX, 0      ; lê da entrada padrão
  mov ECX, vetor2   ; quem deve receber o caractere lido
  mov EDX, 3        ; tamanho da entrada
  int 0x80

  ; esse codigo converte o numero 1 de vetor para inteiro
  mov EDX, 100
  mov ECX, 3
  mov EBX, 0
  convertendo_number1:
      mov EAX, [vetor1 + EBX]     ; movendo conteudo de casa no vetor para EAX
      sub EAX, 48      ; na tabela ASCII, '0' é 48 em decimal
      imul EDX   ; multiplica a posição do vetor por EDX (100, 10, 1)
      add EBX, 1
      add [number1], EAX     ; salva o número na variável number
      mov EAX, EDX        ; dividindo EDX para a próxima casa, move EDX para EAX para dividi-lo por 10
      mov EDX, 10           ; salvando 10 no registrador EDX para jogar na variável [divisor]
      mov [divisor], EDX    ; [divisor] = 10
      mov EDX, 0          ; zera o edx para fazer a expansão
      cdq                 ; dividendo EDX:EAX
      idiv dword [divisor]        ; dividindo o EDX:EAX por 10 (divisor)
      mov EDX, EAX        ; movendo o resultado da divisão para EDX
  loop convertendo_number1

  ; esse codigo converte o numero 2 de vetor para inteiro
  mov EDX, 100
  mov ECX, 3
  mov EBX, 0
  convertendo_number2:
      mov EAX, [vetor2 + EBX]    ; movendo conteudo de casa no vetor para EAX
      sub EAX, 48      ; na tabela ASCII, '0' é 48 em decimal
      imul EDX   ; multiplica a posição do vetor por EDX (100, 10, 1)
      add EBX, 1
      add [number2], EAX     ; salva o número na variável number
      mov EAX, EDX        ; dividindo EDX para a próxima casa, move EDX para EAX para dividi-lo por 10
      mov EDX, 10           ; salvando 10 no registrador EDX para jogar na variável [divisor]
      mov [divisor], EDX    ; [divisor] = 10
      mov EDX, 0          ; zera o edx para fazer a expansão
      cdq                 ; dividendo EDX:EAX
      idiv dword [divisor]        ; dividindo o EDX:EAX por 10 (divisor)
      mov EDX, EAX        ; movendo o resultado da divisão para EDX
  loop convertendo_number2

  ; realizando a soma dos dois numeros
  mov EAX, 0
  add EAX, number1
  add EAX, number2

  ;convertendo [resultado] em vetor



  ;imprimindo o valor do resultado que está em EAX
  ;mov EAX, 4
  ;mov EBX
