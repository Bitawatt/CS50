#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

string replace(string s, string vowels, string numbers);

int main(int argc, string argv[])
{
    string s;
    // Check if the right number of arguments are provided
    if(argc < 2 || argc >2)
    {
        s = "Hello, World!";
        printf("Usage: ./program \"string\"\n");
    }
    else
    {
        s = argv[1];
    }

    string vowels = "aeiouAEIOU";
    string numbers = "4310843108";
    string replaced = replace(s, vowels, numbers);

    printf("%s\n", replaced);
    free(replaced); // Don't forget to free the allocated memory
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

// GitHub Copilot: `malloc` is a function in C that is used to dynamically allocate memory at runtime.
// It stands for "memory allocation". When you call `malloc`, you specify the amount of memory you want
// to allocate (in bytes), and `malloc` returns a pointer to the allocated memory.

// In the [above] code, `malloc` is used to allocate memory for a copy of the input string.
// The size of the allocated memory is the length of the input string plus one (for the null character
// that marks the end of the string).

// The reason for using `malloc` here is to avoid modifying the original string. In C, strings are often
// represented as arrays of characters, and if the original string is a string literal or otherwise
// resides in read-only memory, attempting to modify it can lead to undefined behavior.

// After you're done with a piece of memory that you've allocated with `malloc`, it's important to free
// it using the `free` function. This tells the system that you're done with the memory and it can be
// reused for other purposes. If you don't do this, the memory stays allocated until your program ends,
// which can lead to a memory leak if you're repeatedly allocating memory without freeing it.

// In the provided code, `free` is used to deallocate the memory for the copy of the string after it's
// no longer needed. This is good practice and helps to prevent memory leaks.