#ifndef PATHS_H_INCLUDED
#define PATHS_H_INCLUDED
#include "liste.h"

//Structure de début ou fin de falsepath
struct Timegroup{
    char* nom_tg;   //nom
    Liste comp;     //liste des composants
};
typedef struct Timegroup Timegroup;

//Structure des fils du falsepath entre le début et la fin
struct Nets{
    char* nom_nets;     //nom
    Liste nets;         //liste des fils
};
typedef struct Nets Nets;

//Structure réprésentant le faux chemin
struct Falsepath{
    char* nom_fp;           //nom du faux chemin
    Timegroup* tg_in;       //Timegroup du début
    Timegroup* tg_out;      //Timegroup de fin
    Nets* tg_nets;          //Fils du falsepath
};
typedef struct Falsepath Falsepath;


Timegroup* creer_Timegroup(char* nom_tg);
void ajouter_Au_Timegroup(Timegroup* tg, char* comp);

Nets* creer_Nets(char* nom_nets);
void ajouter_Au_Nets(Nets* nt, char* net);

Falsepath* creer_Falsepath();
Falsepath* creer_Falsepath_Param(char* nom_fp, char* nom_in, char* nom_out, char* nom_nets);
#endif // DETECTION_H_INCLUDED

