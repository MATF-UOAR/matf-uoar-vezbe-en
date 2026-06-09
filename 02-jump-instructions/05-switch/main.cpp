#include <iostream>

extern "C" int days_in_month(int month);

int main()
{
    int month;
    std::cin >> month;

    int days = days_in_month(month);
    if (days == -1)
    {
        std::cout << "Invalid month\n";
    }
    else
    {
        std::cout << "Number of days: " << days << '\n';
    }

    return 0;
}
