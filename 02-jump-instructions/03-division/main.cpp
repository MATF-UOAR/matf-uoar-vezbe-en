#include <iostream>

using namespace std;


extern "C" void divide_int(int a, int b, int &quotient, int &remainder);

extern "C" void divide_unsigned(unsigned a, unsigned b, unsigned &quotient, unsigned &remainder);

int main()
{
    int x, y;
    cout << "[int]\n";
    cout << "Enter a and b: ";
    cin >> x >> y;
    int quotient, remainder;
    divide_int(x, y, quotient, remainder);
    cout << "Result: " << x << " / " << y << " = " << quotient
         << ", " << x << " % " << y << " = " << remainder << "\n\n";

    unsigned ux, uy;
    cout << "[unsigned]\n";
    cout << "Enter a and b: ";
    cin >> ux >> uy;
    unsigned uquotient, uremainder;
    divide_unsigned(ux, uy, uquotient, uremainder);
    cout << "Result: " << ux << " / " << uy << " = " << uquotient
         << ", " << ux << " % " << uy << " = " << uremainder << endl;

    return 0;
}
