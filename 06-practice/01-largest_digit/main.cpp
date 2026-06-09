#include<iostream>


extern "C" unsigned largest_digit(unsigned);



int main()
{
    unsigned n;
    std::cin>>n;


    std::cout<<largest_digit(n)<<"\n";
    return 0;
}
