#include <iostream>
#include <vector>
using namespace std;

extern "C" int more_even_digits(long *a, int n);

int main()
{
    int n;
    cin >> n;
    vector<long> a(n);
    for (int i = 0; i < n; i++)
        cin >> a[i];
    cout << more_even_digits(a.data(), n) << "\n";
    return 0;
}

