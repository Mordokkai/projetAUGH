
#include <augh.h>

// FIFO channels for input and output
// Accesses to these variable will be replaced by AUGH by FIFO handshakes
uint8_t stdin;
uint8_t  stdout;

// Arrays used for input and output
uint8_t input[3];
uint8_t output[2];

void bidon(){
output[0]=(input[0]+input[1])*input[2]*input[0]*(input[1]-input[2]*input[0]);
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
		fifo_write(stdout, &output[2]);

	}while(1);

}



