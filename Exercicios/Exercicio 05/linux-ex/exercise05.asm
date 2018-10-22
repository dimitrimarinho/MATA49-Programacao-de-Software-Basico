%include "asm_io.inc"

segment .data

segment .bss

segment .text
        global  asm_main


asm_main:

        mov eax, msg1
        call print_string


        call read_int



        call print_int


        
        call print_nl

        leave
        ret
