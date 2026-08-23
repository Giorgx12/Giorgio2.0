global outb:
outb:
    mov dx, byte [esp+4]
    mov al, word [esp]
    out dx, al
    ret
