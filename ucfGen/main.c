#include <stdio.h>
#include <stdlib.h>
#include "paths.h"
int main()
{
    printf("Hello world!\n");


    Falsepath* fp = creer_Falsepath_Param("TS1","entree","sortie","chaine");

    ajouter_Au_Timegroup(fp->tg_in,"buf_in_1");
    ajouter_Au_Timegroup(fp->tg_in,"buf_in_2");
    ajouter_Au_Timegroup(fp->tg_in,"buf_in_3");

    ajouter_Au_Timegroup(fp->tg_out,"buf_out_1");
    ajouter_Au_Timegroup(fp->tg_out,"buf_out_2");
    ajouter_Au_Timegroup(fp->tg_out,"buf_out_3");

    ajouter_Au_Nets(fp->tg_nets, "fil_1");
    ajouter_Au_Nets(fp->tg_nets, "fil_2");
    ajouter_Au_Nets(fp->tg_nets, "fil_3");

    FILE* fichier = ouvrir_fichier("contraintes.ucf");

    print_Falsepath(fichier,fp);

    fermer_fichier(fichier);

    return 0;
}
