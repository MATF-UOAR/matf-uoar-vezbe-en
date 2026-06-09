#include <iostream>

extern "C" void set_01(int &a, int &b);

int main()
{
    int a, b;
    std::cin >> a >> b;
    std::cout << "a=" << a << " b=" << b << std::endl;
    set_01(a, b);
    std::cout << "a=" << a << " b=" << b << std::endl;
    return 0;
}
