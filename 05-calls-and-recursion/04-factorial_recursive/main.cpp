#include <iostream>

extern "C" unsigned factorial_recursive(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;

    std::cout << n << "! = " << factorial_recursive(n) << std::endl;
    return 0;
}
