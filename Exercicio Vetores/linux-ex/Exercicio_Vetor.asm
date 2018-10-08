;Obs: O código deve estar dentro da pasta da biblioteca
%include "asm_io.inc"

segment .data   ; Variáveis inicializadas

segment .bss     ; Variáveis não inicializadas

    vetorChar resb 10
    k resd 1

segment .text    ; Código do programa

        global  asm_main

asm_main:

    call read_int   ; eax = inteiro lido
    mov [k], eax
    mov ecx, 10
    mov ebx, 0
    mov esi, vetorChar
    call read_char

    Create_vetorChar:
          call read_char
          mov [esi+ebx], al
          add ebx, 1
    loop Create_vetorChar

    mov ebx, 0
    mov ecx, 10

    Criptography:
         mov eax, [k]
         add [esi+ebx], eax
         mov dl, 90
         cmp [esi+ebx], dl
         jg greater
         jle next
         greater:
          mov dl, 26
          sub [esi+ebx], dl
         next:
          add ebx, 1
    loop Criptography

    mov esi, vetorChar
    mov ecx, 10
    cld
    print:
        lodsb
        call print_char
    loop print

    call print_nl

leave
ret
