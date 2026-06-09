#include <iostream>
#include <string>

extern "C" void reverse_string_recursive(char *s);

int main()
{
    std::string s;
    std::cin >> s;

    reverse_string_recursive(&s[0]);
    std::cout << s << std::endl;
    return 0;
}
