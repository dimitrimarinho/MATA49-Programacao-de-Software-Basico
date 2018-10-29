; nasm -f elf32 Exercicio_Fibonacci.asm && gcc -m32 -o Exercicio_Fibonacci Exercicio_Fibonacci.o driver.c asm_io.o && ./Exercicio_Fibonacci
%include "asm_io.inc"

segment .data

segment .bss

segment .text
        global  asm_main

fibonacci:
        enter 0, 0
        push EAX
        push EBX
        push ECX

        mov EAX, 0
        push EAX
        mov EBX, 1
        push EBX
        add EAX, EBX
        push EAX



        ; mov EAX, 0
        ; push EAX
        ; mov EAX, 1
        ; push EAX
        ; mov EBX, [ESP + 8]
        ; cmp

        fim_fibonacci:
                      pop ECX
                      pop EBX
                      pop EAX

asm_main:

        call read_int       ; EAX = inteiro lido
        push EAX
        call fibonacci

        leave
        ret
