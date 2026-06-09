#include <iostream>
#include <vector>

extern "C" int find_first(unsigned *a, int n, int (*pred)(unsigned));

int is_even(unsigned x)
{
    return x % 2 == 0;
}

int greater_than_99(unsigned x)
{
    return x > 99;
}

void print_result(const char *description, int index)
{
    if (index == -1)
    {
        std::cout << description << ": no matches" << std::endl;
    }
    else
    {
        std::cout << description << ": index " << index << std::endl;
    }
}

int main()
{
    int n;
    std::cin >> n;

    std::vector<unsigned> a(n);
    for (int i = 0; i < n; i++)
    {
        std::cin >> a[i];
    }

    print_result("first even", find_first(a.data(), n, is_even));
    print_result("first > 99", find_first(a.data(), n, greater_than_99));

    return 0;
}
