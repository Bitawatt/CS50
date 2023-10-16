#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

string replace(string s, string find, string replace);

int main(int argc, string argv[])
{
    // Check if the right number of arguments are provided
    if(argc < 3 || argc % 2 != 1) {
        printf("Usage: ./program string pair1 pair2 ...\n");
        return 1;
    }

    string s = argv[1]; // Get the string from the command line arguments

    for(int i = 2; i < argc; i += 2) {
        string find = argv[i];
        string replaceWith = argv[i+1];
        s = replace(s, find, replaceWith);
    }

    printf("%s\n", s);
    free(s); // Don't forget to free the allocated memory
    return 0;
}

string replace(string s, string find, string replaceWith)
{
    string result = malloc(strlen(s) + 1);
    strcpy(result, s);
    for (int i = 0; result[i] != '\0'; i++)
    {
        for (int j = 0; find[j] != '\0'; j++)
        {
            if (result[i] == find[j])
            {
                result[i] = replaceWith[j];
                break; // break the inner loop once a replacement is made
            }
        }
    }
    return result;
}