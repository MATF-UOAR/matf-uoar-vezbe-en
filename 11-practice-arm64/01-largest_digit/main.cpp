#include <iostream>

extern "C" unsigned largest_digit(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;

    std::cout << largest_digit(n) << std::endl;

    return 0;
}
