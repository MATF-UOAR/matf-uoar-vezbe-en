#include <iostream>
#include <vector>

extern "C" int dot_product(int *a, int *b, int n);

int main()
{
    int n;
    std::cin >> n;

    std::vector<int> a(n);
    std::vector<int> b(n);

    for (int i = 0; i < n; i++)
    {
        std::cin >> a[i];
    }
    for (int i = 0; i < n; i++)
    {
        std::cin >> b[i];
    }

    std::cout << dot_product(a.data(), b.data(), n) << std::endl;

    return 0;
}
