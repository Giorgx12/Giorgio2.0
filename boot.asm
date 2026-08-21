[org 0x7c00]
start:
mov ah, 0x0E
mov al, 'A'
int 0x10
infinite_loop:
jmp infinite_loop
times 510-($-$$) db 0
dw 0xAA55