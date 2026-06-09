#include <iostream>

extern "C" int sum_two(int a, int b);

int main() {
    int a, b;
    std::cin >> a >> b;
    std::cout << sum_two(a, b) << std::endl;
    return 0;
}