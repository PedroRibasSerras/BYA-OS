;Recebe a casa de memória inicial da string registrador bx
clean_screan:
    pusha

    mov ah , 0x02
    mov bh , 0x00
    mov dh , 0x00
    mov dl , 0x00

    int 0x10

    mov ah , 0x0e

    mov dh, 0x00
    mov dl, 0x00
    mov al , ' '

clean_row_loop:

    cmp dh , 25
    je clean_row_done

clean_col_loop:
    cmp dl , 80
    je clean_col_done

    int 0x10
    add dl , 1

    jmp clean_col_loop

clean_col_done:
    mov dl , 0
    add dh , 1
    jmp clean_row_loop


clean_row_done:
    mov ah , 0x02
    mov bh , 0x00
    mov dh , 0x00
    mov dl , 0x00

    int 0x10

    popa
    ret