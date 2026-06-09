#include <iostream>

extern "C" unsigned replace_largest_digit(unsigned n, unsigned c);

int main()
{
    unsigned n;
    unsigned c;
    std::cin >> n >> c;

    std::cout << replace_largest_digit(n, c) << std::endl;

    return 0;
}
