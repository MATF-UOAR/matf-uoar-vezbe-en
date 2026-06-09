#include<iostream>


extern "C" unsigned new_number(unsigned);




int main()
{
    unsigned n;
    std::cin>>n;

    std::cout<<new_number(n)<<"\n";
    return 0;
}
