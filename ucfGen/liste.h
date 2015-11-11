#ifndef LISTE_H_INCLUDED
#define LISTE_H_INCLUDED
#include <stdlib.h>
#include <stdio.h>



struct element{
    char* nom;
    struct element* suiv;
};
typedef struct element element;
typedef struct element* Liste;

element* creerElem();
Liste ajouterEnTete(Liste liste, char* nom);
Liste ajouterEnFin(Liste liste, char* nom);
void afficherListe(Liste liste);
int estVide(Liste liste);
#endif
