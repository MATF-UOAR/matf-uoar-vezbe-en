#include<iostream>

extern "C" int is_fibonacci(int);


int main()
{
    int n;
    std::cin>>n;

    int result = is_fibonacci(n);
    if(result==-1)
	std::cout<<"Does not belong to the Fibonacci sequence!\n";
    else
	std::cout<<"index: "<<result<<"\n";
    
    return 0;
}
