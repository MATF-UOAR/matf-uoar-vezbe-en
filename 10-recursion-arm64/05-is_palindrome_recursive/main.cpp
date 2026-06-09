#include <iostream>

extern "C" int is_palindrome_recursive(const char *s);

int main()
{
    std::string s;
    std::cin >> s;

    if (is_palindrome_recursive(s.c_str()))
    {
        std::cout << "palindrome" << std::endl;
    }
    else
    {
        std::cout << "not a palindrome" << std::endl;
    }

    return 0;
}
