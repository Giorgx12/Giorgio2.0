[BITS 16]
org 0x7c00
section .text
global start
start:
    mov ax, 0x0003
    int 0x10

    mov ax, 0xb800
    mov ds, ax
    mov es, ax

    mov byte [0], 'B'
    mov byte [1], 0x0F

hang:
    jmp hang

times 510 - ($ - $$) db 0
dw 0xaa55
