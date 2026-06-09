#include <iostream>

extern "C" unsigned gcd_recursive(unsigned a, unsigned b);

int main()
{
    unsigned a, b;
    std::cin >> a >> b;

    std::cout << "gcd(" << a << ", " << b << ") = "
              << gcd_recursive(a, b) << std::endl;
    return 0;
}
