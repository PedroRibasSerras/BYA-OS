; A boot sector that enters 32 - bit protected mode.
[ bits 16 ]
[ org 0x7c00 ]
    mov bx, MSG_REAL_MODE
    mov ah , 0x0e

print_string_loop:
    mov al , [ bx ]
    cmp al , 0
    je print_string_done

    int 0x10
    add bx , 1

    jmp print_string_loop

print_string_done:
    jmp $

MSG_REAL_MODE:
    db 'Teste' , 0

times 510 -( $ - $$ ) db 0
dw 0xaa55