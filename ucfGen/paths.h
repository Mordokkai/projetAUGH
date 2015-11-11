#ifndef PATHS_H_INCLUDED
#define PATHS_H_INCLUDED
#include "liste.h"
struct Timegroup{
    char* nom_tg;   //nom char*
    Liste comp;     //liste de composants
};
typedef struct Timegroup Timegroup;

struct Nets{
    char* nom_nets;  //nom char*
    Liste nets;
};
typedef struct Nets Nets;

struct Falsepath{
    char* nom_fp;
    Timegroup* tg_in;    //from timegroup
    Timegroup* tg_out;   //to timegroup
    Nets* tg_nets;        //through Nets
};
typedef struct Falsepath Falsepath;


Timegroup* creer_Timegroup(char* nom_tg);
void ajouter_Au_Timegroup(Timegroup* tg, char* comp);
Nets* creer_Nets(char* nom_nets);
void ajouter_Au_Nets(Nets* nt, char* net);
Falsepath* creer_Falsepath();
Falsepath* creer_Falsepath_Param(char* nom_fp, char* nom_in, char* nom_out, char* nom_nets);
#endif // DETECTION_H_INCLUDED

