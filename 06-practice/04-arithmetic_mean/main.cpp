#include<iostream>
#include<vector>

extern "C" unsigned arithmetic_mean(unsigned*,int);



int main()
{
    int n;
    std::cin>>n;
    std::vector<unsigned> a(n);


    for(int i=0;i<n;i++)
	std::cin>>a[i];


    std::cout<<arithmetic_mean(a.data(),n)<<"\n";
    
    return 0;
}
