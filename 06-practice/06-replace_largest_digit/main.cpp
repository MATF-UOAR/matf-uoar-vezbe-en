#include<iostream>

extern "C" unsigned replace_largest_digit(unsigned,unsigned);



int main()
{
    unsigned n,digit;
    std::cin>>n>>digit;

    std::cout<<replace_largest_digit(n,digit)<<"\n";
    return 0;
}
