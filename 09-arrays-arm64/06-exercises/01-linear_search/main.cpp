#include <iostream>
#include <vector>

extern "C" int linear_search(int *a, int n, int x);

int main() {
    int n;
    std::cin >> n;

    std::vector<int> a(n);
    for (int i = 0; i < n; i++) {
        std::cin >> a[i];
    }

    int x;
    std::cin >> x;

    int index = linear_search(a.data(), n, x);

    std::cout << index << std::endl;

    return 0;
}
