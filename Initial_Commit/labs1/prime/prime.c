#include <cs50.h>
#include <stdio.h>
#include <math.h>
#include <stdbool.h>
#include <time.h>

bool prime(int number);

int main(void)
{
    clock_t start, end;
    double cpu_time_used;

    start = clock(); // Start a clock to get execution time

    int min;
    do
    {
        min = get_int("Minimum: ");
    }
    while (min < 1);

    int max;
    do
    {
        max = get_int("Maximum: ");
    }
    while (min >= max);

    for (int i = min; i <= max; i++)
    {   
        if (prime(i))
        {
            printf("%i\n", i);
        }
    }
    end = clock();

    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

    printf("Execution time: %f seconds\n", cpu_time_used);

    return 0;
}

bool prime(int number)
{
    if (number <= 1) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;
    for (int i = 3; i <= sqrt(number); i += 2) {
        if (number % i == 0) return false;
    }
    return true;
}

 // TODO
    // If i/2 == int = true
    //  then stop
    // If i/2 == int = false
    //  then divide by numbers within another conditional:
    // if a&b (the two factors that would be multiples of the 'prime candidate') are both > or both < (prime candidate)^(1/2)...
    // or in other words, when the resulting factor is either also >, or also <, the square root of the 'prime candidate' division can stop.
    // OHHH - I made that a little complicated! So, in other words, we only have to divide by number < the square root of the 'prime candidate' - that's easier to say:)
    // So - all odd numbers greater than (one and min) and < the 'sqrt' of i < max
    // Damn - this is fast!