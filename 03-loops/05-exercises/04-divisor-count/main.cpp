#include <iostream>

extern "C" unsigned divisor_count(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;
    std::cout << "Divisor count: " << divisor_count(n) << std::endl;
    return 0;
}
