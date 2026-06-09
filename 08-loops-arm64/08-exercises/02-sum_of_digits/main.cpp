#include <iostream>

extern "C" unsigned sum_of_digits(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;
    std::cout << "Sum of digits: " << sum_of_digits(n) << std::endl;
    return 0;
}
