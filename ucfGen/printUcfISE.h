#ifndef PRINTUCFISE_H_INCLUDED
#define PRINTUCFISE_H_INCLUDED
#include <stdlib.h>
#include <stdio.h>
#include "paths.h"

FILE* ouvrir_fichier(char* nom_fichier_ucf);
FILE* fermer_fichier(char* nom_fichier_ucf);
void print_Falsepath(FILE* f, Falsepath* fp);
void print_Timegroup(FILE* f, Timegroup* tg);




#endif // LISTE_H_INCLUDED
