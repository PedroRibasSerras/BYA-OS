; A boot sector that enters 32 - bit protected mode.
[ bits 16 ]
[ org 0x7c00 ]

KERNEL_OFFSET equ 0x1000

    mov [ BOOT_DRIVE ] , dl

    mov bp , 0x9000
; Set the stack.
    mov sp , bp
    mov bx , MSG_REAL_MODE
    call print_string
 ; Note that we never return from here.
    mov bx , MSG_LOAD_KERNEL
    call print_string
    
    mov bx , KERNEL_OFFSET
    mov dh , 15
    mov dl , [ BOOT_DRIVE ]
    call disk_load
    call KERNEL_OFFSET
    
    jmp $



%include "./libs/print_string.asm"
%include "./libs/disk_load.asm"

BOOT_DRIVE: db 0
MSG_REAL_MODE: db 'Started in 16 - bit Real Mode' , 0
MSG_LOAD_KERNEL: db " Loading kernel into memory. " , 0
; Bootsector padding
    times 510 -( $ - $$ ) db 0
    dw 0xaa55