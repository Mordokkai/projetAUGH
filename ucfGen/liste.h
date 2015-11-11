#ifndef LISTE_H_INCLUDED
#define LISTE_H_INCLUDED
#include <stdlib.h>
#include <stdio.h>

// Noeud d'une liste
struct element{
    char* nom;
    struct element* suiv;
};
typedef struct element element;

//Liste
typedef struct element* Liste;

//Créer un noeud
element* creerElem();

Liste ajouterEnTete(Liste liste, char* nom);

Liste ajouterEnFin(Liste liste, char* nom);

void afficherListe(Liste liste);

int estVide(Liste liste);
#endif
