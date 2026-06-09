#include <iostream>
#include <string>
using namespace std;

extern "C" int clean_string(char *s);

int main()
{
    string s;
    getline(cin, s);
    int r = clean_string(s.data());
    cout << s << "\n"
         << r << "\n";
    return 0;
}

