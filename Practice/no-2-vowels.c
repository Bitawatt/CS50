// Write a function to replace vowels with numbers and spaces with underscores
// Get practice with strings
// Get practice with command line
// Get practice with switch

#include <cs50.h>
#include <stdio.h>

int main(int argc, string argv[])
{
    Loop through string, replacing vowels with numbers 
    string replace(s, "aeiouAEIOU", "4310843108")
    {
        for (int i = 0; s[i] != '\0'; i++)
        {
            for (int j = 0; vowels[j] != '\0'; j++)
            {
                if (s[i] == vowels[j])
                {
                    s[i] = numbers[j];
                }
            }
        }
        return s;
    
}


#include <cs50.h>
#include <stdio.h>

string replace(string s, string vowels, string numbers)
{
    for (int i = 0; s[i] != '\0'; i++)
    {
        for (int j = 0; vowels[j] != '\0'; j++)
        {
            if (s[i] == vowels[j])
            {
                s[i] = numbers[j];
                break; // break the inner loop once a replacement is made
            }
        }
    }
    return s;
}

int main(int argc, string argv[])
{
    string s = "Hello, World!";
    printf("%s\n", replace(s, "aeiouAEIOU", "4310843108"));
    return 0;
}