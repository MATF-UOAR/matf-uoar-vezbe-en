#include <iostream>

extern "C" unsigned count_ones_recursive(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;

    std::cout << count_ones_recursive(n) << std::endl;

    return 0;
}
