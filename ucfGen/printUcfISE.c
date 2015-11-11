#include "printUcfISE.h"

FILE* ouvrir_fichier(char* nom_fichier_ucf){
    FILE* f = fopen(nom_fichier_ucf,"wa");

    if(f==NULL){
        printf("Problème lors de l'ouverture du fichier\n");
    }
    else{
        return f;
    }
}

FILE* fermer_fichier(char* nom_fichier_ucf){
    fclose(nom_fichier_ucf);
}

void print_Falsepath(FILE* f, Falsepath* fp){
    print_Timegroup(f,fp->tg_in);
    print_Timegroup(f,fp->tg_out);
    print_Nets(f,fp->tg_nets);
    print_end(f, fp);

}

void print_Timegroup(FILE* f, Timegroup* tg){
    Liste p = tg->comp;
    while(p!=NULL){
        char* ligne = malloc(256*sizeof(char));
        strcpy(ligne,"INST \"");
        strcat(ligne, p->nom);
        strcat(ligne, "\" TNM = ");
        strcat(ligne, tg->nom_tg);
        strcat(ligne, ";\n");
        fprintf(f,ligne);
        p = p->suiv;
    }
}

void print_Nets(FILE* f, Nets* nt){
    Liste p = nt->nets;
    while(p!=NULL){
        char* ligne = malloc(256*sizeof(char));
        strcpy(ligne,"NET \"");
        strcat(ligne, p->nom);
        strcat(ligne, "\" TPTHRU = \"");
        strcat(ligne, nt->nom_nets);
        strcat(ligne, "\";\n");
        fprintf(f,ligne);
        p = p->suiv;
    }
}

void print_end(FILE* f,Falsepath* fp){
//TIMESPEC TS_1 = FROM "input_i" THRU "chaine3" TO "output_i" TIG;
    char* ligne = malloc(256*sizeof(char));
    strcpy(ligne,"TIMESPEC ");
    strcat(ligne, fp->nom_fp);
    strcat(ligne, " = FROM \"");
    strcat(ligne, fp->tg_in->nom_tg);
    strcat(ligne, "\" THRU \"");
    strcat(ligne, fp->tg_nets->nom_nets);
    strcat(ligne, "\" TO \"");
    strcat(ligne, fp->tg_out->nom_tg);
    strcat(ligne, "\" TIG;");
    fprintf(f,ligne);
}



