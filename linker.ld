ENTRY(start)

SECTIONS
{
    . = 0x7C00;

    .text : {
        boot.o (.text)
        *(.text)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
}
