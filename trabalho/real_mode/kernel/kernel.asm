[ bits 16 ]
[ org 0x1000 ]

mov bx , MSG_DENTRO_KERNEL

call print_string



call clean_screan

keyboard_init:
    mov ah , 0x0e
    mov al , '>'
    int 0x10

    mov al , ' '
    int 0x10



keyboard_loop:

    mov ah , 0x00
    int 0x16
    
    cmp al, 0x0d
    je action

    cmp al, 0x08
    je backspace

    mov bx, [KEYBOARD_BUFFER_POSITION]
    mov [KEYBOARD_BUFFER + bx], al

    add bx, 1
    mov [KEYBOARD_BUFFER_POSITION], bx

    mov ah , 0x0e
    int 0x10

    jmp keyboard_loop

backspace:
    mov bx, [KEYBOARD_BUFFER_POSITION]
    
    cmp bx, 0x00
    je keyboard_loop

    sub bx, 1
    mov cl,0x00
    mov [KEYBOARD_BUFFER + bx], cl

    mov [KEYBOARD_BUFFER_POSITION], bx

    mov ah , 0x0e
    mov al , 0x08
    int 0x10

    mov ah , 0x0e
    mov al , 0
    int 0x10

    mov ah , 0x0e
    mov al , 0x08
    int 0x10

    jmp keyboard_loop


action:
    ;finaliza keyboard_buffer
    mov bx, [KEYBOARD_BUFFER_POSITION]
    mov al, 0x00
    mov [KEYBOARD_BUFFER + bx], al
    ;reseta keyboard_buffer cursor    
    mov bx, 0
    mov [KEYBOARD_BUFFER_POSITION], bx

    ;pula linha

    mov ah , 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10

    ;teste de comparar string
    mov bx, KEYBOARD_BUFFER
    mov cx, TEST_STR_1
    call cmp_str
    cmp al,0
    je t2
    call print_string
t2:
    mov bx, KEYBOARD_BUFFER
    mov cx, TEST_STR_2
    call cmp_str
    cmp al,0
    je nl
    call print_string
    jmp nl

    

    mov bx , KEYBOARD_BUFFER
    call print_string

nl:
    mov ah , 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10

    jmp keyboard_init
    


jmp $

%include "./libs/print_string.asm"
%include "./libs/clean_screan.asm"
%include "./libs/cmp_str.asm"

KEYBOARD_BUFFER_POSITION: dw 0x0000
KEYBOARD_BUFFER: times 512 db 0
MSG_DENTRO_KERNEL: db 'Estamos no kernel!' , 0
MSG_FAZ_ALGO: db 'Faz alguma coisa!' , 0
TEST_STR_1: db "1",0
TEST_STR_2: db "oi tudo certo", 0