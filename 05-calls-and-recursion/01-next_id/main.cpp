#include <iostream>

extern "C" unsigned next_id();

int main()
{
    for (int i = 0; i < 4; i++)
    {
        std::cout << next_id() << std::endl;
    }

    return 0;
}
