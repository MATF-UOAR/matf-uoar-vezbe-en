#include <iostream>
#include <vector>

extern "C" int array_sum(int* niz, int n);

int main() {
    int n;
    std::cin >> n;

    std::vector<int> niz(n);
    for (int i = 0; i < n; i++) {
        std::cin >> niz[i];
    }

    std::cout << array_sum(niz.data(), n) << std::endl;

    return 0;
}