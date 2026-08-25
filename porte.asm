PIC1_COMMAND equ 0x20
PIC1_DATA equ 0x21
PIC2_COMMAND equ 0xA0
PIC2_DATA equ 0xA1
global outb
outb:
    mov dx, word [esp + 4]
    mov al, byte [esp + 8]
    out dx, al
    ret
global inb
inb:
    mov dx, word [esp+4]
    in al, dx
    ret
global pic_remap
pic_remap:
    push 0x11
    push PIC1_COMMAND
    call outb
    add esp, 8
    push 0x11
    push PIC2_COMMAND
    call outb
    add esp, 8
    push 0x20
    push PIC1_DATA
    call outb
    add esp, 8
    push 0x28
    push PIC2_DATA
    call outb
    add esp, 8
    push 0x04
    push PIC1_DATA
    call outb
    add esp, 8
    push 0x02
    push PIC2_DATA
    call outb
    add esp, 8
    push 0x01
    push PIC1_DATA
    call outb
    add esp, 8
    push 0x01
    push PIC2_DATA
    call outb
    add esp, 8
    push 0xFC
    push PIC1_DATA
    call outb
    add esp, 8
    push 0xFF
    push PIC2_DATA
    call outb
    add esp, 8
    ret
global lidt
lidt:
    lidt [esp+4]
    ret
