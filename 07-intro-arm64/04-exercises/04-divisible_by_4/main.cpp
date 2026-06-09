#include <iostream>

extern "C" int divisible_by_4(int x);

int main() {
    int x;
    std::cin >> x;

    if (divisible_by_4(x)) {
        std::cout << "Divisible" << std::endl;
    }
    else {
        std::cout << "Not divisible" << std::endl;
    }

    return 0;
}
