#include <iostream>
#include <vector>

extern "C" void array_of_largest_digits(unsigned *a, unsigned *res, int n);

int main()
{
    int n;
    std::cin >> n;

    std::vector<unsigned> a(n);
    for (int i = 0; i < n; i++)
    {
        std::cin >> a[i];
    }

    std::vector<unsigned> res(n);
    array_of_largest_digits(a.data(), res.data(), n);

    for (int i = 0; i < n; i++)
    {
        std::cout << res[i] << " ";
    }
    std::cout << std::endl;

    return 0;
}
