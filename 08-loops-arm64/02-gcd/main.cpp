#include <iostream>

extern "C" unsigned gcd(unsigned a, unsigned b);

int main()
{
    unsigned a, b;
    std::cin >> a >> b;
    std::cout << "GCD(" << a << ", " << b << ") = " << gcd(a, b) << std::endl;
    return 0;
}
