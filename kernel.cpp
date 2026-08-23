int cursore = 0;
char tabella_scancode[128];
extern "C" void outb(unsigned short porta, unsigned char valore);
extern "C" unsigned char inb(unsigned short porta);
void aggiorna_cursore_hardware(int posizione){
    unsigned char parte_bassa = posizione & 0xFF;
    unsigned char parte_alta = posizione >> 8;
    outb(0x3D4, 0x0F);
    outb(0x3D5, parte_bassa);
    outb(0x3D4, 0x0E);
    outb(0x3D5, parte_alta);
}
void inizializza_tabella(){
    tabella_scancode[0x1E] = 'a';
    tabella_scancode[0x30] = 'b';
    tabella_scancode[0x2E] = 'c';
    tabella_scancode[0x20] = 'd';
    tabella_scancode[0x12] = 'e';
    tabella_scancode[0x21] = 'f';
    tabella_scancode[0x22] = 'g';
    tabella_scancode[0x23] = 'h';
    tabella_scancode[0x17] = 'i';
    tabella_scancode[0x24] = 'j';
    tabella_scancode[0x25] = 'k';
    tabella_scancode[0x26] = 'l';
    tabella_scancode[0x32] = 'm';
    tabella_scancode[0x31] = 'n';
    tabella_scancode[0x18] = 'o';
    tabella_scancode[0x19] = 'p';
    tabella_scancode[0x10] = 'q';
    tabella_scancode[0x13] = 'r';
    tabella_scancode[0x1F] = 's';
    tabella_scancode[0x14] = 't';
    tabella_scancode[0x16] = 'u';
    tabella_scancode[0x2F] = 'v';
    tabella_scancode[0x11] = 'w';
    tabella_scancode[0x2D] = 'x';
    tabella_scancode[0x15] = 'y';
    tabella_scancode[0x2C] = 'z';
    tabella_scancode[0x02] = '1';
    tabella_scancode[0x03] = '2';
    tabella_scancode[0x04] = '3';
    tabella_scancode[0x05] = '4';
    tabella_scancode[0x06] = '5';
    tabella_scancode[0x07] = '6';
    tabella_scancode[0x08] = '7';
    tabella_scancode[0x09] = '8';
    tabella_scancode[0x0A] = '9';
    tabella_scancode[0x0B] = '0';
    tabella_scancode[0x39] = ' ';  
    tabella_scancode[0x1C] = '\n';  
    tabella_scancode[0x0E] = '\b'; 
}


char* memoria_video = (char*)0xb8000;
void stampa_lettera(char lettera, int colore){
    if (lettera == '\n'){
        cursore += 80;
        aggiorna_cursore_hardware(cursore);
      return;
    }
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
void leggi_tastiera() {
    unsigned char sc = inb(0x60);
    if (sc != 0) {
        stampa_lettera(tabella_tastiera[sc], 7);
    }
}
void stampa_stringa(const char* stringa, int colore){
    while (*stringa){
        stampa_lettera(*stringa, colore);
        stringa++;
    }
}
extern "C" void kernel_main() {
    inizializza_tabella();
    stampa_stringa("That's Giorgio2.0", 7); 
    
    while(1) {
        leggi_tastiera();
    }
}    
