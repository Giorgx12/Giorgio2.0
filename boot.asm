[BITS 16]
org 0x7c00
section .text
global start
start:
    mov ax, 0x1000
    mov es, ax
    mov bx, 0x0000
    mov ah, 0x02
    mov al, 32
    mov ch, 0
    mov cl, 1
    mov dh, 0
    mov dl, 0x00
    int 0x13
    jc disk_error

    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:pm

[BITS 32]
pm:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov edi, 0xb8000
    mov ecx, 2000
    mov ax, 0x0720
cls:
    mov [edi], ax
    add edi, 2
    loop cls

    mov byte [0xb8000], 'B'
    mov byte [0xb8001], 0x0F

    mov eax, 0x00010000
    jmp eax

disk_error:
    mov ax, 0xb800
    mov ds, ax
    mov es, ax
    mov byte [0], 'E'
    mov byte [1], 0x0C
    jmp disk_error

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
