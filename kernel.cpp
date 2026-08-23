int cursore = 0;
void stampa_lettera(char lettera, int colore){
    if (lettera == '\n'){
        cursore += 80;
        return;
    }
    char* memoria_video = (char*) 0xb8000;
    memoria_video[cursore * 2] = lettera;
    int cursore_colore = cursore * 2 + 1; 
    switch(colore){
        case (0):
            memoria_video[cursore_colore] = 0x00;
            break;
        case (1):
            memoria_video[cursore_colore] = 0x01;
            break;
        case (2):
            memoria_video[cursore_colore] = 0x02;
            break;
        case (3):
            memoria_video[cursore_colore] = 0x03;
            break;
        case (4): 
            memoria_video[cursore_colore] = 0x04;
            break;
        case (5): 
            memoria_video[cursore_colore] = 0x05;
            break;
        case (6): 
            memoria_video[cursore_colore] = 0x06;
            break;
        case (7): 
            memoria_video[cursore_colore] = 0x07;
            break;
        case (8): 
            memoria_video[cursore_colore] = 0x08;
            break;
        case (9): 
            memoria_video[cursore_colore] = 0x09;
            break;
        case (10):
            memoria_video[cursore_colore] = 0x0a;
            break;
        case (11): 
            memoria_video[cursore_colore] = 0x0b;
            break;
        case (12): 
            memoria_video[cursore_colore] = 0x0c;
            break;
        case (13):
            memoria_video[cursore_colore] = 0x0d;
            break;
        case (14): 
            memoria_video[cursore_colore] = 0x0e;
            break;
        case (15):
            memoria_video[cursore_colore] = 0x0f;
            break;
    }
    cursore ++;
    if (cursore >= 80 * 25) {
        for (int i = 0; i < 24 * 160; i++){
            memoria_video[i] = memoria_video[i+160];
        }
        for (int i = 24 * 160; i < 25 * 160 - 1; i += 2){
            memoria_video[i] = ' ';
            memoria_video[i + 1] = 0x07;
        }
        cursore = 24 * 80;
    }
    aggiorna_cursore_hardware(cursore);
}
extern "C" void outb(unsigned short porta, unsigned char valore){}
void aggiorna_cursore_hardware(int posizione){
    unsigned char parte_bassa = posizione & 0xFF;
    unsigned char parte_alta = posizione >> 8;
    outb(0x3D4, 0x0F);
    outb(0x3D5, parte_bassa);
    outb(0x3D4, 0x0E);
    outb(0x3D5, parte_alta);
}
void stampa_stringa(const char* stringa, int colore){
    while (*stringa){
        stampa_lettera(*stringa, colore);
        stringa++;
    }
}
extern "C" void kernel_main() {
    stampa_stringa("That's Giorgio2.0", 7); 
    
    while(1) {
    
    }
}    
