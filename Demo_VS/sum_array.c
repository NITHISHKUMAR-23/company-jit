#include<stdio.h>
int sum(int *a, int size);
int main()
{
    int size;
    scanf("%d",&size);
    int a[size];
    for(int i=0;i<size;i++)
    scanf("%d",&a[i]);
    printf("%d",sum(&a,size));
}
int sum (int *a,int size)
{
    int b=0;
    for(int i=0;i<size;i++)
    {
        b=b+*(a+i);
    }
    return b;
}