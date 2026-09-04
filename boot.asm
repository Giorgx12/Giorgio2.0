[BITS 16]
org 0x7c00
section .text
global start
start:
    mov ax, 0x1000
    mov es, ax
    mov bx, 0
    mov ah, 2
    mov al, 32
    mov ch, 0
    mov cl, 1
    mov dh, 0
    mov dl, 0
    int 0x13
    mov byte [es:0], 0xAB
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:protected_mode_start
[BITS 32]
protected_mode_start:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov edi, 0xb8000
    mov ecx, 2000
    mov ax, 0x0720
clear_screen:
    mov [edi], ax
    add edi, 2
    loop clear_screen
    mov al, byte [0x00010000]
    cmp al, 0xAB
    je kernel_here
    mov byte [0xb8000], 'N'
    jmp hang
kernel_here:
    jmp 0x08:0x00010000
hang:
    jmp hang
gdt_start:
    dq 0
gdt_code:
    dw 0xffff, 0
    db 0, 10011010b, 11001111b, 0
gdt_data:
    dw 0xffff, 0
    db 0, 10010010b, 11001111b, 0
gdt_end:
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start
times 510 - ($ - $$) db 0
dw 0xaa55
