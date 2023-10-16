#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

string replace(string s, string vowels, string numbers);

int main(int argc, string argv[])
{
    // Check if the right number of arguments are provided
    if(argc < 2)
    {
        printf("Usage: ./program string\n");
        return 1;
    }

    // Calculate the total length of all arguments
    int totalLength = 0;
    for(int i = 1; i < argc; i++)
    {
        totalLength += strlen(argv[i]);
    }

    // Add space for the spaces between arguments and the null character
    totalLength += argc - 2 + 1;

    // Allocate memory for the string
    string s = malloc(totalLength * sizeof(char));

    // Concatenate all arguments into the string
    strcpy(s, argv[1]);
    for(int i = 2; i < argc; i++)
    {
        strcat(s, " ");
        strcat(s, argv[i]);
    }

    string vowels = "aeiouAEIOU";
    string numbers = "4310843108";
    string replaced = replace(s, vowels, numbers);

    printf("%s\n", replaced);
    free(replaced); // Don't forget to free the allocated memory
    free(s); // Free the memory allocated for the string
    return 0;
}

string replace(string s, string vowels, string numbers)
{
    string result = malloc(strlen(s) + 1);
    strcpy(result, s);
    for (int i = 0; result[i] != '\0'; i++)
    {
        for (int j = 0; vowels[j] != '\0'; j++)
        {
            if (result[i] == vowels[j])
            {
                result[i] = numbers[j];
                break; // break the inner loop once a replacement is made
            }
        }
    }
    return result;
}