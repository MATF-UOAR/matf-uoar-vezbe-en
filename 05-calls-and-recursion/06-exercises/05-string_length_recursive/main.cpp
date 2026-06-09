#include <iostream>
#include <string>

extern "C" int string_length_recursive(const char *s);

int main()
{
    std::string s;
    std::cin >> s;

    std::cout << string_length_recursive(s.c_str()) << std::endl;
    return 0;
}
