#include <iostream>

extern "C" void divisible_by_4(int x);

int main()
{
    int x;
    std::cin >> x;
    divisible_by_4(x);
    return 0;
}
