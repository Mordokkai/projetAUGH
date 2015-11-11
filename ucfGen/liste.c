#include "liste.h"

Liste ajouterEnTete(Liste liste, char* nom){
    element* newElem = creerElem();
    strcpy(newElem->nom,nom);
    newElem->suiv=liste;
    return newElem;
}

element* creerElem(){
    element* newElem = malloc(sizeof(element));
    newElem->nom = malloc(15*sizeof(char));
    return newElem;
}

Liste ajouterEnFin(Liste liste, char* nom){
    element* newElem = creerElem();
    strcpy(newElem->nom,nom);
    newElem->suiv=NULL;

    if(liste==NULL){
        return newElem;
    }
    else{
        element* p=liste;
        while(p->suiv != NULL){
            p= p->suiv;
        }
        p->suiv=newElem;
        return liste;
    }
}

void afficherListe(Liste liste){
    if(liste==NULL){
        printf("La liste est vide");
    }
    else{
        Liste p=liste;
        while(p!=NULL){
            if(p->nom==NULL) printf("pb");
            else{
                printf("%s\n",p->nom);
                p=p->suiv;
            }
        }
    }
}

int estVide(Liste liste){
    return (liste==NULL)? 1:0;
}


