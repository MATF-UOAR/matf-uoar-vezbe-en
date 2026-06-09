#include <iostream>
#include <vector>

extern "C" int dot_product(int* a, int* b, int n);

int main() {
    int n;
    std::cin >> n;

    std::vector<int> a(n > 0 ? n : 0), b(n > 0 ? n : 0);

    for (int i = 0; i < n; i++) {
        std::cin >> a[i];
    }

    for (int i = 0; i < n; i++) {
        std::cin >> b[i];
    }

    std::cout << dot_product(a.data(), b.data(), n) << std::endl;

    return 0;
}
