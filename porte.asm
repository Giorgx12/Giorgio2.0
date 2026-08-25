mov PIC1_COMMAND, 0x20
mov PIC1_DATA, 0x21
mov PCI2_COMMAND, 0xA0
mov PCI2_DATA, 0xA1
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
    outb(PCI1_COMMAND, 0x11)
    outb(PCI2_COMMAND, 0x11)
    outb(PCI1_DATA, 0x20)
    outb(PCI2_DATA, 0x28)
    outb(PCI1_DATA, 0x04)
    outb(PCI2_DATA, 0x02)
    outb(PCI1_DATA, 0x01)
    outb(PCI2_DATA, 0x01)
    outb(PCI1_DATA, 0xFC)
    outb(PCI2_DATA, 0xFF)
    ret
