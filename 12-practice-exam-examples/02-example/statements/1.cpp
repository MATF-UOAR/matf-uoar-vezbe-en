#include <iostream>
using namespace std;

extern "C" unsigned long weight(unsigned long x);

int main()
{
    unsigned long x;
    cin >> x;
    cout << weight(x) << "\n";
    return 0;
}

