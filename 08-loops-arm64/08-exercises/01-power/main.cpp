#include <iostream>

extern "C" unsigned power(unsigned a, unsigned n);

int main()
{
    unsigned a, n;
    std::cin >> a >> n;
    std::cout << a << "^" << n << " = " << power(a, n) << std::endl;
    return 0;
}
