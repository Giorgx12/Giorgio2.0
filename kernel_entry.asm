[BITS 32]
global _start
extern kernel_main
_start:
    mov byte [0xb8000], 'K'
    mov byte [0xb8001], 0x0F
    call kernel_main
hang:
    jmp hang
