#include <iostream>
#include <string>

extern "C" char most_frequent_letter(const char *s);

int main()
{
    std::string s;
    std::cin >> s;

    std::cout << most_frequent_letter(s.c_str()) << std::endl;
    return 0;
}
