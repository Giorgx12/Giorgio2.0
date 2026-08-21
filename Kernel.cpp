void stampa_lettera(char lettera, int colore){
    char* memoria_video = (char*) 0xb8000;
    memoria_video[0] = lettera;
    switch(colore){
        case (0):
            memoria_video[1] = 0x00;
            break;
        case (1):
            memoria_video[1] = 0x01;
            break;
        case (2):
            memoria_video[1] = 0x02;
            break;
        case (3):
            memoria_video[1] = 0x03;
            break;
        case (4): 
            memoria_video[1] = 0x04;
            break;
        case (5): 
            memoria_video[1] = 0x05;
            break;
        case (6): 
            memoria_video[1] = 0x06;
            break;
        case (7): 
            memoria_video[1] = 0x07;
            break;
        case (8): 
            memoria_video[1] = 0x08;
            break;
        case (9): 
            memoria_video[1] = 0x09;
            break;
        case (10):
            memoria_video[1] = 0x0a;
            break;
        case (11): 
            memoria_video[1] = 0x0b;
            break;
        case (12): 
            memoria_video[1] = 0x0c;
            break;
        case (13):
            memoria_video[1] = 0x0d;
            break;
        case (14): 
            memoria_video[1] = 0x0e;
            break;
        case (15):
            memoria_video[1] = 0x0f;
            break;
    }
extern "C" void kernel_main() {
    stampa_lettera('A', 7); // Dovrebbe stampare una 'A' sullo schermo!
    
    while(1) {
        // Ciclo infinito per impedire al kernel di spegnersi o crashare
    }
}    