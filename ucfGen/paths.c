#include <stdlib.h>
#include "paths.h"

Timegroup* creer_Timegroup(char* nom_tg){
    Timegroup* tg = malloc(sizeof(Timegroup));
    tg->nom_tg = malloc(15*sizeof(char));
    strcpy(tg->nom_tg,nom_tg);
    tg->comp = NULL;
}

void ajouter_Au_Timegroup(Timegroup* tg, char* comp){
    if(tg==NULL){
        printf("Il faut d'abord créer le Timegroup \n");
    }
    else{
        tg->comp = ajouterEnFin(tg->comp,comp);
    }
}

Nets* creer_Nets(char* nom_nets){
    Nets* nt = malloc(nt);
    nt->nom_nets = malloc(15*sizeof(char));
    strcpy(nt->nom_nets,nom_nets);
    nt->nets = NULL;
}

void ajouter_Au_Nets(Nets* nt, char* net){
    if(nt==NULL){
        printf("Il faut d'abord créer le Nets \n");
    }
    else{
        nt->nets = ajouterEnFin(nt->nets,net);
    }
}

Falsepath* creer_Falsepath(){
    Falsepath* fp = malloc(sizeof(Falsepath));
    fp->tg_in = NULL;
    fp->tg_out = NULL;
    fp->tg_nets = NULL;
    return fp;
}

Falsepath* creer_Falsepath_Param(char* nom_fp, char* nom_in, char* nom_out, char* nom_nets){
    Falsepath* fp = malloc(sizeof(Falsepath));
    fp->nom_fp = malloc(15*sizeof(char));
    strcpy(fp->nom_fp,nom_fp);
    fp->tg_in = creer_Timegroup(nom_in);
    fp->tg_out = creer_Timegroup(nom_out);
    fp->tg_nets = creer_Nets(nom_nets);
    return fp;
}





