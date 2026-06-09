#include <iostream>

extern "C" unsigned is_prime(unsigned n);

int main()
{
    unsigned n;
    std::cin >> n;

    if (is_prime(n)) {
        std::cout << "Number is prime" << std::endl;
    }
    else {
        std::cout << "Number is not prime" << std::endl;
    }

    return 0;
}
