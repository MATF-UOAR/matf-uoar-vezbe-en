#include <iostream>

extern "C" unsigned most_frequent_digit(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;
    std::cout << most_frequent_digit(n) << std::endl;
    return 0;
}
