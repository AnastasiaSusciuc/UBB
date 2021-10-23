//
// Created by susci on 10/7/2021.
//

#ifndef R1_P8A_H
#define R1_P8A_H


//tip de data generic (pentru moment este intreg)
typedef int TElem;

//referire a structurii Nod;
struct Nod;

//se defineste tipul PNod ca fiind adresa unui Nod
typedef Nod *PNod;

struct Nod{
    TElem e;
    PNod urm;
};

typedef struct{
//prim este adresa primului Nod din lista
    PNod _prim;
} Lista;

//operatii pe lista - INTERFATA

//crearea unei liste din valori citite pana la 0
Lista creare();

// computes the lowest common multiple of a list
int compute_lcm(Lista l);

// substitute in the list l all the elements equals to old_element with new_element
Lista substitute(Lista l, int old_element, int new_element);

//tiparirea elementelor unei liste
void tipar(Lista l);

// destructorul listei
void distruge(Lista l);

int length(Lista l);

#endif //R1_P8A_H
