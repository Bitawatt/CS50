#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool only_digits(string arg);
string cipher(string p_text, int key);

int main(int argc, string argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }
    if (only_digits(argv[1]) == false)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }

    int key = atoi(argv[1]);

    string p_text = get_string("plaintext:  ");
    string c_text = cipher(p_text, key);

    printf("ciphertext: %s\n", c_text);

    // string d_text = cipher(c_text, -key);

    // printf("decrypted text: %s\n", d_text);

    free(c_text);
    // free(d_text);

    return 0;
}

bool only_digits(string arg)
{
    bool only_digits = false;
    for (int i = 0; i < strlen(arg); i++)
    {
        if (!isdigit(arg[i]))
        {
            return false;
        }
    }
    return true;
}

string cipher(string p_text, int key)
{
    string c_text = malloc(strlen(p_text) + 1);
    for (int i = 0; i < strlen(p_text); i++)
    {
        if (isupper(p_text[i]))
        {
            c_text[i] = (char) ((p_text[i] - 'A' + key) % 26 + 'A');
        }
        else if (islower(p_text[i]))
        {
            c_text[i] = (char) ((p_text[i] - 'a' + key) % 26 + 'a');
        }
        else
        {
            c_text[i] = p_text[i];
        }
    }
    c_text[strlen(p_text)] = '\0';
    return c_text;
}