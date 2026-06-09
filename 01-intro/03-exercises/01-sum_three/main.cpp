#include <iostream>

extern "C" int sum_three(int a, int b, int c);

int main() {
    int a, b, c;
    std::cin >> a >> b >> c;
    std::cout << sum_three(a, b, c) << '\n';
    return 0;
}
