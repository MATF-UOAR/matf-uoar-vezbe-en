#include<iostream>
#include<vector>

extern "C" void count_above_mean(unsigned*,int);



int main()
{
    int n;
    std::cin>>n;

    std::vector<unsigned> a(n);
    for(int i=0;i<n;i++)
	std::cin>>a[i];

    count_above_mean(a.data(),n);
    
    for(int i=0;i<n;i++)
	std::cout<<a[i]<<" ";

    std::cout<<"\n";
    
    return 0;
}
