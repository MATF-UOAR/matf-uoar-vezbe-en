#include <iostream>

extern "C" unsigned power_recursive(unsigned a, unsigned n);

int main()
{
    unsigned a, n;
    std::cin >> a >> n;

    std::cout << a << "^" << n << " = " << power_recursive(a, n) << std::endl;
    return 0;
}
