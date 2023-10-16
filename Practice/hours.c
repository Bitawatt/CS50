#include <cs50.h>
#include <stdio.h>
#include <ctype.h>



// The main function prompts the user for the number of weeks a user has been taking CS50, then creates an array with as many elements. 
// Notice that, after retrieving some data, the program prompts the user to type in either “T” or “A”—”T” should (but doesn’t yet!) 
// print the total number of hours the user entered, while “A” should (but doesn’t yet!) print the average hours the user entered. 
// Notice that the do while loop uses toupper to capitalize the letter that’s input before it is saved in the variable output. 
// Then, the printf function calls calc_hours. Note the syntax involved when passing an array to a function.

// To complete calc_hours, first total up the hours saved in the array into a new variable. Then, depending on the value of output, 
// return either this sum, or the average number of hours.

int calc_hours(int hours[], int weeks);
float avg_hours(int hours[], int weeks);

int main(void)
{
    int weeks;
    do
    {
        printf("How many weeks have you been taking CS50? ");
        weeks = GetInt();
    }
    while (weeks < 1);

    int hours[weeks];
    for (int i = 0; i < weeks; i++)
    {
        printf("How many hours did you spend on CS50 week %i? ", i);
        hours[i] = GetInt();
    }

    char output;
    do
    {
        printf("Type \"T\" to get the total number of hours, or \"A\" to get the average: ");
        output = GetChar();
    }
    while (output != 'T' && output != 't' && output != 'A' && output != 'a');

    if (output == 'T' || output == 't')
    {
        printf("You have spent ");
        printf("%i", calc_hours(hours, weeks));
        printf(" hours on CS50.\n");
    }
    else if (output == 'A' || output == 'a')
    {
        printf("You have spent ");
        printf("%i", calc_hours(hours, weeks));
        printf(" hours on CS50, on average.\n");
    }
}

int calc_hours(int hours[], int weeks)
{
    int total = 0;
    for (int i = 0; i < weeks; i++)
    {
        total += hours[i];
    }
    return total;
}

float avg_hours(int hours[], int weeks)
{
    float total = 0;
    float average = 0;
    for (int i = 0; i < weeks; i++)
    {
        total += hours[i];
        average = total / weeks;
    }
    return (float) average;
}