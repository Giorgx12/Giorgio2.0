[BITS 32]
global _start
extern kernel_main
_start:
    call kernel_main
hang:
    jmp hang
