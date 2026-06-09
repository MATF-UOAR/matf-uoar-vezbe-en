#include <iostream>

extern "C" unsigned euler(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;
    std::cout << euler(n) << std::endl;
    return 0;
}
