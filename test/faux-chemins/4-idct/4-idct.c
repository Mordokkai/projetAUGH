
#include <augh.h>

// FIFO channels for input and output
// Accesses to these variable will be replaced by AUGH by FIFO handshakes
int32_t stdin;
int8_t  stdout;

// Arrays used for input and output
int32_t input[64];
uint8_t output[64];

// Arrays used for internal calculations
int32_t idct_z1[8], idct_z2[8], idct_z3[8];


// Access 1D arrays with 2D coordinates
#define LINCOORD(x,y) (((x)<<3)|((y)&0x7))

// Another handy macro
// This activates rounding (and makes all expressions totally unreadable)
//#define PLUSHIFT(x) ((((x)>>13)+1)>>1)
// This disables rounding
#define PLUSHIFT(x) ((x)>>14)


// Perform the 1D IDCT
// Defined as a macro because AUGH doesn't like pointers
// The *_idx variables are offsets, meant to be multiplied by 8
#define IDCT_ID(in, in_idx, out, out_idx) do { \
	/* Stage 1 */ \
	idct_z1[1] = in[LINCOORD(in_idx,0)] - in[LINCOORD(in_idx,4)]; \
	idct_z1[0] = in[LINCOORD(in_idx,0)] + in[LINCOORD(in_idx,4)]; \
	idct_z1[2] = PLUSHIFT(8867  * in[LINCOORD(in_idx,2)]) - PLUSHIFT(21407 * in[LINCOORD(in_idx,6)]); \
	idct_z1[3] = PLUSHIFT(21407 * in[LINCOORD(in_idx,2)]) - PLUSHIFT(8867  * in[LINCOORD(in_idx,6)]); \
	idct_z1[4] = in[LINCOORD(in_idx,1)] - in[LINCOORD(in_idx,7)]; \
	idct_z1[7] = in[LINCOORD(in_idx,1)] + in[LINCOORD(in_idx,7)]; \
	idct_z1[5] = PLUSHIFT(23170 * in[LINCOORD(in_idx,3)]); \
	idct_z1[6] = PLUSHIFT(23170 * in[LINCOORD(in_idx,5)]); \
	/* Stage 2 */ \
	idct_z2[3] = idct_z1[0] - idct_z1[3]; \
	idct_z2[0] = idct_z1[0] + idct_z1[3]; \
	idct_z2[2] = idct_z1[1] - idct_z1[2]; \
	idct_z2[1] = idct_z1[1] + idct_z1[2]; \
	idct_z2[6] = idct_z1[4] - idct_z1[6]; \
	idct_z2[4] = idct_z1[4] + idct_z1[6]; \
	idct_z2[5] = idct_z1[7] - idct_z1[5]; \
	idct_z2[7] = idct_z1[7] + idct_z1[5]; \
	/* Stage 3 */ \
	idct_z3[0] = idct_z2[0]; \
	idct_z3[1] = idct_z2[1]; \
	idct_z3[2] = idct_z2[2]; \
	idct_z3[3] = idct_z2[3]; \
	idct_z3[4] = PLUSHIFT(13623 * idct_z2[4]) - PLUSHIFT(9102  * idct_z2[7]); \
	idct_z3[7] = PLUSHIFT(9102  * idct_z2[4]) + PLUSHIFT(13623 * idct_z2[7]); \
	idct_z3[5] = PLUSHIFT(16069 * idct_z2[5]) - PLUSHIFT(3196  * idct_z2[6]); \
	idct_z3[6] = PLUSHIFT(3196  * idct_z2[5]) + PLUSHIFT(16069 * idct_z2[6]); \
	/* Stage 4 */ \
	out[LINCOORD(out_idx,7)] = idct_z3[0] - idct_z3[7]; \
	out[LINCOORD(out_idx,0)] = idct_z3[0] + idct_z3[7]; \
	out[LINCOORD(out_idx,6)] = idct_z3[1] - idct_z3[6]; \
	out[LINCOORD(out_idx,1)] = idct_z3[1] + idct_z3[6]; \
	out[LINCOORD(out_idx,5)] = idct_z3[2] - idct_z3[5]; \
	out[LINCOORD(out_idx,2)] = idct_z3[2] + idct_z3[5]; \
	out[LINCOORD(out_idx,4)] = idct_z3[3] - idct_z3[4]; \
	out[LINCOORD(out_idx,3)] = idct_z3[3] + idct_z3[4]; \
}while(0)


// Perform the 2D IDCT
// Input data is read from the shared array "input"
// Output data is written to the shared array "output"
static inline void IDCT_2D() {
	unsigned k, l;
	int32_t r;
	int32_t Yc[8];

	// Scale
	loopscale:
	for(k=0; k<64; k++) input[k] = input[k] << 3;

	// First IDCT
	loopidct1:
	for(k=0; k<8; k++) {
		IDCT_ID(input, k, input, k);
	}

	// Second IDCT
	loopidct2:
	for(l=0; l<8; l++) {

		// Transposition
		looptranspose:
		for(k=0; k<8; k++) Yc[k] = input[LINCOORD(k, l)];

		// IDCT
		IDCT_ID(Yc, 0, Yc, 0);

		// Descale
		loopdescale:
		for(k=0; k<8; k++) {
			r = ((Yc[k] + 0x20) >> 6) + 128;
			minval:
			if(r<0) output[LINCOORD(k, l)] = 0;
			else {
				maxval:
				if(r>255) output[LINCOORD(k, l)] = 255;
				else      output[LINCOORD(k, l)] = r;
			}
		}

	}
}


// The top-level function for AUGH
void augh_main () {
	unsigned k;

	do {

		loopinput:
		for (k = 0; k < 64; k++) fifo_read(stdin, &input[k]);

		IDCT_2D();

		loopoutput:
		for (k = 0; k < 64; k++) fifo_write(stdout, &output[k]);

	}while(1);

}



