; nasm -f elf32 exercise05.asm && gcc -m32 -o exercise05 exercise05.o driver.c asm_io.o && ./exercise05
%include "asm_io.inc"

segment .data

segment .bss

segment .text
        global  asm_main

asm_main:

        mov ecx, 30
        mov ebx, 0
        reading_word:
          call read_char
          cmp al, ' '
          je Invert
          cmp al, '.'
          je Finish
          movzx eax, al
          push eax
          inc ebx
        loop reading_word

        Invert:
        mov ecx, ebx
          lp:
            pop eax
            call print_char
          loop lp

        mov al, ' '
        call print_char
        mov ecx, 30
        mov ebx, 0
        jmp reading_word

        Finish:

        mov ecx, ebx
        invert_last:
          pop eax
          call print_char
        loop invert_last
        call print_nl

        leave
        ret
