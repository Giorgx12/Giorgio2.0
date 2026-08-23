global outb:
outb:
    mov dx, word [esp+4]
    mov al, byte [esp + 8]
    out dx, al
    ret
