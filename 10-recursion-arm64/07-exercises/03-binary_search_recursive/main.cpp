#include <iostream>
#include <vector>

extern "C" int binary_search_recursive(int *a, int left, int right, int x);

int main()
{
    int n;
    std::cin >> n;

    std::vector<int> a(n);
    for (int i = 0; i < n; i++)
    {
        std::cin >> a[i];
    }

    int x;
    std::cin >> x;

    std::cout << binary_search_recursive(a.data(), 0, n - 1, x)
              << std::endl;
    return 0;
}
