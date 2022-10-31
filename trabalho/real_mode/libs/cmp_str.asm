;Recebe a casa de memória inicial das string em bx e cx
;Retorna em al 1 se for igual e 0 se for diferente
cmp_str:
    pusha
cmp_str_loop:
    mov al , [ bx ]
    mov dx , bx
    mov bx , cx
    mov ah , [ bx ]    
    cmp al, ah
    jne cmp_str_not_equal

    cmp al, 0
    je cmp_str_equal

    mov bx, dx
    add bx, 1
    add cx, 1
    jmp cmp_str_loop

cmp_str_not_equal:
    mov al, 0x00
    jmp cmp_str_done
cmp_str_equal:
    mov al,0x01
cmp_str_done:
    mov [IS_EQUAL], al
    popa
    mov al, [IS_EQUAL]
    ret

IS_EQUAL: db 0