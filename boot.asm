[BITS 16]
org 0x7c00
section .text
global start  
start:
    mov ax, 0x1000
    mov es, ax
    mov bx, 0x0000
    mov ah, 0x02     
    mov al, 20   
    mov ch, 0        
    mov cl, 2       
    mov dh, 0        
    mov dl, 0x00     
    int 0x13
    jc disk_error
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
    jmp 0x00010000

hang:
    jmp hang

gdt_start:
    dq 0x0
gdt_code:
    dw 0xffff, 0x0000
    db 0x00, 10011010b, 11001111b, 0x00
gdt_data:
    dw 0xffff, 0x0000
    db 0x00, 10010010b, 11001111b, 0x00
gdt_end:
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start
disk_error:
    mov edi, 0xb8000
    mov eax, 0x4F45      ; 'E' rosso
    mov [edi], eax
    jmp disk_error

times 510 - ($ - $$) db 0
dw 0xaa55
