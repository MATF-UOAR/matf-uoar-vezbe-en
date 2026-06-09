#include <iostream>

extern "C" unsigned sum_of_evens(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;
    std::cout << sum_of_evens(n) << std::endl;
    return 0;
}
