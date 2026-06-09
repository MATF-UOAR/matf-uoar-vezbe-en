#include <iostream>
#include <vector>

extern "C" int index_of_max(int *a, int n);

int main() {
    int n;
    std::cin >> n;

    std::vector<int> a(n);
    for (int i = 0; i < n; i++) {
        std::cin >> a[i];
    }

    std::cout << index_of_max(a.data(), n) << std::endl;

    return 0;
}
