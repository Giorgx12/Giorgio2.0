outb:
    mov dx, [ESP+4]
    mov al, [ESP]
    out dx, al
    ret
