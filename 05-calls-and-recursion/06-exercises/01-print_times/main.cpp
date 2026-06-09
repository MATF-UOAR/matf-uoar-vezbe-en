#include <iostream>
#include <string>

extern "C" void print_times(const char *s, unsigned n);

int main()
{
    unsigned n;
    std::string s;

    std::cin >> n >> s;
    print_times(s.c_str(), n);

    return 0;
}
