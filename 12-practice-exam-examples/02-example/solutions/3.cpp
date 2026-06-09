#include <iostream>
#include <vector>
using namespace std;

extern "C" int count_in_range(unsigned long *a, int n,
                              unsigned long l, unsigned long r);

int main()
{
    int n;
    cin >> n;
    vector<unsigned long> a(n);
    for (int i = 0; i < n; i++)
        cin >> a[i];
    unsigned long l, r;
    cin >> l >> r;
    cout << count_in_range(a.data(), n, l, r) << "\n";
    return 0;
}

