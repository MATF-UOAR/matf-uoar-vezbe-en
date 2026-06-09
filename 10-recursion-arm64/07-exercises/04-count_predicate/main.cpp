#include <iostream>
#include <vector>

extern "C" int count_predicate(unsigned *a, int n, int (*pred)(unsigned));

int is_even(unsigned x)
{
    return x % 2 == 0;
}

int greater_than_99(unsigned x)
{
    return x > 99;
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

    std::cout << "evens: "
              << count_predicate(a.data(), n, is_even) << std::endl;
    std::cout << "> 99: "
              << count_predicate(a.data(), n, greater_than_99) << std::endl;
    return 0;
}
