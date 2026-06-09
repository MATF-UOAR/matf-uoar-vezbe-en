#include <iostream>
#include <string>

extern "C" unsigned word_count(const char *s);

int main()
{
    std::string s;
    std::getline(std::cin, s);

    std::cout << word_count(s.c_str()) << std::endl;

    return 0;
}
