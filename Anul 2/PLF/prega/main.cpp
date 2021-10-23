#include <iostream>
using namespace std;

unsigned long long n, c, r;

unsigned long long get(unsigned long long n, unsigned long long c, unsigned long long r)
{
    for (unsigned long long  i = n+1; ; i++)
        if (i%c == r) {
            return i;
        }
}

int main() {

    while (true) {
       n = rand()%100;
       c = rand()%100;
       r = rand()%c;
        if (n == 0) continue;
        std::cout << n << " " << c << " "<< r << '\n';
       if ((n/c+1)*c+r != get(n, c, r))
       {
           std::cout << n << " " << c << " "<< r;
           return 0;
       }
    }

    return 0;
}
