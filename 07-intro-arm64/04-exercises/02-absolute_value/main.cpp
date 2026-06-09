#include <iostream>

extern "C" int absolute_value(int x);

int main() {
    int x;
    std::cin >> x;
    std::cout << absolute_value(x) << std::endl;
    return 0;
}
