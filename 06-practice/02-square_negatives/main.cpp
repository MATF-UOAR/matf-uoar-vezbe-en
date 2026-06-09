#include<iostream>
#include<vector>

extern "C" void square_negatives(int*,int);

int main()
{
    int n;
    std::cin>>n;
    std::vector<int> a(n);
    
    for(int i=0;i<n;i++)
	std::cin>>a[i];

    square_negatives(a.data(),n);


    for(int i=0;i<n;i++)
	std::cout<<a[i]<<" ";
    
    
    return 0;
}
