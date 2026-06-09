#include <iostream>

extern "C" unsigned count_ones(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;
    std::cout << "Count of ones: " << count_ones(n) << std::endl;
    return 0;
}
