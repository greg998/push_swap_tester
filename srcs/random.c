
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

static inline int in(int *nums, int len, int val)
{
    int i = 0;
    while (i < len)
    {
        if (val == nums[i])
            return (1);
        i++;
    }
    return (0);
}

int main(int argc, char **argv)
{
    int quantity;
    long int range;
    int i = 0, randomNum;

    quantity = atoi(argv[1]);
    int nums[quantity];
    range = 2147483647;
    if (argc == 3)
        range = atoi(argv[2]);
    range++;
    srand(time(NULL) + getpid());
    while (i < quantity)
    {
        randomNum = rand() % range;
        if (rand() % 2 == 1)
            randomNum *= -1;
        while (in(nums, i, randomNum))
        {
            randomNum = rand() % range;
        }
        printf("%d ", randomNum);
        nums[i] = randomNum;
        i++;
    }
    return 0;
}