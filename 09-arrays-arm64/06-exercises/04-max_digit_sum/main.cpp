#include <iostream>
#include <vector>

extern "C" unsigned max_digit_sum(unsigned *a, int n);

int main() {
    int n;
    std::cin >> n;

    std::vector<unsigned> a(n);
    for (int i = 0; i < n; i++) {
        std::cin >> a[i];
    }

    std::cout << max_digit_sum(a.data(), n) << std::endl;

    return 0;
}
