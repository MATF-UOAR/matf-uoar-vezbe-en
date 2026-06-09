#include <iostream>

extern "C" unsigned gcd(unsigned a, unsigned b);

int main()
{
    unsigned a, b;
    std::cin >> a >> b;
    std::cout << "gcd(" << a << ", " << b << ") = " << gcd(a, b) << std::endl;
    return 0;
}
