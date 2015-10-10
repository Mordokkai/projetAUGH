
#include <augh.h>

// FIFO channels for input and output
// Accesses to these variable will be replaced by AUGH by FIFO handshakes
uint8_t stdin;
uint8_t  stdout;

// Arrays used for input and output
uint8_t input[1];
uint8_t output[1];

void bidon(){
	output[0] = (input[0]*3+input[0])*56;
	output[0] += (input[0]-input[0]+input[0])*input[0];
}

// The top-level function for AUGH
void augh_main () {

	do {

		fifo_read(stdin, &input[0]);

		bidon();

		fifo_write(stdout, &output[0]);

	}while(1);

}



