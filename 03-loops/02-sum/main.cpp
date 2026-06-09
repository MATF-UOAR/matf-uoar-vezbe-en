#include <iostream>

extern "C" unsigned sum_to_n(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;
    std::cout << sum_to_n(n) << std::endl;
    return 0;
}
