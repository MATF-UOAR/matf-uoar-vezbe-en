#include <iostream>
#include <vector>
using namespace std;

extern "C" unsigned long heaviest(unsigned long *a, int n);

int main()
{
    int n;
    cin >> n;
    vector<unsigned long> a(n);
    for (int i = 0; i < n; i++)
        cin >> a[i];
    cout << heaviest(a.data(), n) << "\n";
    return 0;
}

