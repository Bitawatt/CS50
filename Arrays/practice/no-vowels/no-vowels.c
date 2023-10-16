// Write a function to replace vowels with numbers
// Get practice with strings
// Get practice with command line
// Get practice with switch

#include <cs50.h>
#include <stdio.h>

string s[];
string replace(s, argv[], argc)

int main(int argc, string argv[])
{
    // Check for correct number of command line arguments

    if (argc != 2)
    {
        printf("Usage: ./no-vowels string\n");
        return 1;
    }

    // Get string from command line
    string s = argv[1];
    string replace(s, argv, argc)

    // Print result
    printf("%s\n", s);
}

string replace(s, argv[], argc)
{
    // Loop through string, replacing vowels with numbers
    for (int i = 0; s[i] != '\0'; i++)
    {
        switch (s[i])
        {
            case 'a':
            case 'A':
                s[i] = '4';
                break;
            case 'e':
            case 'E':
                s[i] = '3';
                break;
            case 'i':
            case 'I':
                s[i] = '1';
                break;
            case 'o':
            case 'O':
                s[i] = '0';
                break;
            case 'u':
            case 'U':
                s[i] = '9';
                break;
        }
        return s;
    }

}