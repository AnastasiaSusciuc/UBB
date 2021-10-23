#include <iostream>
#include "p8a.h"

using namespace std;


int main() {
    std::cout << "Insert the subsection (1 or 2)" << std::endl;

    int subsection;
    cin >> subsection;

    if (subsection == 1) {
        Lista my_list = creare();
        int lcm = compute_lcm(my_list);
//        std::cout << "len is " << length(my_list) << " ";
        if (length(my_list) == 0)
            std::cout << "empty list => lcm does not exist!";
        else
            std::cout << "the lcm is: " << lcm;
        distruge(my_list);
    }
    else if (subsection == 2) {
        Lista my_list = creare();
        int e1, e2;
        std::cout << "Introduce the number to be substituted:"; std::cin >> e1;
        std::cout << "Introduce the number to substitute with:"; std::cin >> e2;
        substitute(my_list, e1, e2);
        tipar(my_list);
        distruge(my_list);
    }
    else
        std::cout << "Invalid option";

    return 0;
}
