#include <cs50.h>
#include <stdio.h>

int main(void)
{

    // Prompt for start size
    int s;
    do
    {
        s = get_int("Start size: ");
    }
    while (s < 9);

    // Prompt for end size
    int e;
    do
    {
        e = get_int("End size: ");
    }
    while (s > e);

    // Calculate number of years until we reach threshold
    int i = 0;
    while (s < e)
    {
        s = (s + (s / 3) - (s / 4));
        i++;
    }

    // Print number of years
    printf("Years: %i\n", i);
    return 0;
}
