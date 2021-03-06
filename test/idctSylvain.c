
#include <augh.h>

// FIFO channels for input and output
// Accesses to these variable will be replaced by AUGH by FIFO handshakes
uint8_t stdin;
uint8_t  stdout;

// Arrays used for input and output
uint8_t input[4];
uint8_t output[1];

void bidon(){
	uint8_t inter;
	if(input[3]==0){
		inter=input[1];
	}
	else
		inter=input[2];
	if(input[3]==0){
		output[0]=input[0];
	}
	else
		output[0]=inter;
}

// The top-level function for AUGH
void augh_main () {

	do {
		unsigned k=0;
		for(k=0;k<4;k++) fifo_read(stdin, &input[k]);

		bidon();

		fifo_write(stdout, &output[0]);

	}while(1);

}



