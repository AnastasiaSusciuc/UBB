//
// Created by susci on 10/7/2021.
//

#include "p8a.h"
#include <iostream>

using namespace std;


PNod creare_rec(){
    TElem x;
    cout << "x=";
    cin >> x;
    if (x == 0)
        return nullptr;
    else {
        PNod p = new Nod();
        p->e = x;
        p->urm = creare_rec();
        return p;
    }
}

Lista creare() {
    Lista l;
    l._prim = creare_rec();
}

int compute_gcd(int n1, int n2) {
    if (n2 != 0)
        return compute_gcd(n2, n1 % n2);
    return n1;
}

int length(Lista l) {
    if (l._prim == nullptr)
        return 0;
    Lista l2;
    l2._prim = l._prim->urm;
    return 1+length(l2);
}

int compute_lcm(Lista l) {
    if (l._prim == nullptr)
        return 1;
    Lista l2;
    l2._prim = l._prim->urm;
    int lcm = compute_lcm(l2);
    int gcd = compute_gcd(lcm, l._prim->e);
    return l._prim->e * lcm / gcd;
}

Lista substitute(Lista l, int old_element, int new_element) {
    if (l._prim == nullptr)
        return l;
    if (l._prim->e == old_element) {
        Lista l2;
        l2._prim = l._prim->urm;
        substitute(l2, old_element, new_element);
        l._prim->e = new_element;
    }
    else {
        Lista l2;
        l2._prim = l._prim->urm;
        substitute(l2, old_element, new_element);
    }
    return l;
}

void tipar_rec(PNod p){
    if (p != nullptr) {
        cout << p->e << " ";
        tipar_rec(p->urm);
    }
}

void tipar(Lista l){
    tipar_rec(l._prim);
}

void distrug_rec(PNod p){
    if (p != nullptr){
        distrug_rec(p->urm);
        delete p;
    }
}

void distruge(Lista l) {
    //se elibereaza memoria alocata nodurilor listei
    distrug_rec(l._prim);
}