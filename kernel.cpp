typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

extern "C" void outb(unsigned short porta, unsigned char valore);
extern "C" unsigned char inb(unsigned short porta);

char* memoria_video = (char*)0xb8000;

extern "C" void kernel_main() {
    memoria_video[0] = 'K';
    memoria_video[1] = 0x0F;

    for (int i = 0; i < 80; i++) {
        memoria_video[i*2] = 'X';
        memoria_video[i*2+1] = 0x0F;
    }

    while (1) {}
}
