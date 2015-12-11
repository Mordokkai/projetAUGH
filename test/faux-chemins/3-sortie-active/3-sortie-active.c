
#include <augh.h>

// FIFO channels for input and output
// Accesses to these variable will be replaced by AUGH by FIFO handshakes
uint8_t stdin;
uint8_t  stdout;

// Arrays used for input and output
uint8_t input[3];
uint8_t output[2];
uint8_t output2[1];

void bidon(){
output[0]=(input[0]+input[1])*input[2];
output[1]=input[0]-(input[1]*input[2]);
output2[0]=(input[1]*input[2]);//rajouter du calcul pour faire un faux chemin qui soit critique ?
}

// The top-level function for AUGH
void augh_main () {

	do {
		fifo_read(stdin, &input[0]);
		fifo_read(stdin, &input[1]);
		fifo_read(stdin, &input[2]);

		bidon();

		fifo_write(stdout, &output[0]);
		fifo_write(stdout, &output[1]);
		fifo_write(stdout, &output2[0]);

	}while(1);

}



