#include <iostream>

extern "C" unsigned lcm(unsigned a, unsigned b);

int main()
{
    unsigned a, b;
    std::cin >> a >> b;
    std::cout << "LCM(" << a << ", " << b << ") = " << lcm(a, b) << std::endl;
    return 0;
}
