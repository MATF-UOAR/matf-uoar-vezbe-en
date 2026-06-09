#include <iostream>

extern "C" void season(int month);

int main()
{
    int month;
    std::cin >> month;
    season(month);
    return 0;
}
