#include <iostream>
#include <vector>

extern "C" int array_sum(int *a, int n);

int main() {
    int n;
    std::cin >> n;

    std::vector<int> a(n);
    for (int i = 0; i < n; i++) {
        std::cin >> a[i];
    }

    int sum = array_sum(a.data(), n);

    std::cout << sum << std::endl;

    return 0;
}