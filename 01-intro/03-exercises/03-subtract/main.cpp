#include <iostream>

extern "C" int subtract(int a, int b);

int main() {
    int a, b;
    std::cin >> a >> b;
    std::cout << subtract(a, b) << '\n';
    return 0;
}
