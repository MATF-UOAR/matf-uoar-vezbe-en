#include <iostream>

extern "C" unsigned factorial(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;
    std::cout << n << "! = " << factorial(n) << std::endl;
    return 0;
}
