#include <iostream>

extern "C" int is_leap_year(int year);

int main()
{
    int year;
    std::cin >> year;

    if (is_leap_year(year) == 1)
    {
        std::cout << "Leap year\n";
    }
    else
    {
        std::cout << "Not a leap year\n";
    }

    return 0;
}
