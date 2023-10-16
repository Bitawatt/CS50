// Check that a password has at least one lowercase letter, uppercase letter, number and symbol
// Practice iterating through a string
// Practice using the ctype library

#include <cs50.h>
#include <stdio.h>

bool valid(string password);

int main(void)
{
    string password = get_string("Enter your password: ");
    if (valid(password))
    {
        printf("Your password is valid!\n");
    }
    else
    {
        printf("Your password needs to be at least 8 characters long and have one uppercase letter, lowercase letter, number and symbol\n");
    }
}

// TODO: Complete the Boolean function below
// int char[] and then check the ranges of ascii characters
bool valid(string password)
{
    // Calculate the length of string
    bool has_special = false;
    bool has_upper = false;
    bool has_lower = false;
    bool has_number = false;
    bool has_length = false;

    int length = 0;
    for(int i = 0; password[i] != '\0'; i++)
    {
        length ++;
        if ((int) password[i] >= 33 && (int) password[i] <= 47)         // special character
            has_special = true;
        else if ((int) password[i] >= 58 && (int) password[i] <= 64)
            has_special = true;
        else if ((int) password[i] >= 91 && (int) password[i] <= 96)
            has_special = true;
        else if ((int) password[i] >= 123 && (int) password[i] <= 126)
            has_special = true;
        else if ((int) password[i] >= 65 && (int) password[i] <= 90)    // uppercase character
            has_upper = true;
        else if ((int) password[i] >= 97 && (int) password[i] <= 122)   // lowercase character
            has_lower = true;
        else if ((int) password[i] >= 48 && (int) password[i] <= 57)    // number
            has_number = true;
    }
    if (length >= 8) // length
        has_length = true;
    return has_special && has_upper && has_lower && has_number && has_length;
}
