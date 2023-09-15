#include <cs50.h>
#include <stdio.h>

int main(void)
{
    long long number;
    int length;
    char *brand;

    number = get_long_long("Number: ");

    // Check Brand
    if ((number > 40e11 && number < 50e11) || (number > 40e14 && number < 50e14))
        brand = "VISA";
    else if (number > 51e14 && number < 56e14)
        brand = "MASTERCARD";
    else if ((number > 34e13 && number < 35e13) || (number > 37e13 && number < 38e13))
        brand = "AMEX";
    else
    {
        printf("INVALID\n");
        brand = NULL;
    }
    if (brand == NULL)
        return 0;

    // Verify Checksum
    // ('number' / 10) and get Remainder, '% 10'; increment process with 'i', updating 'number', followed by an 'if':
    // if 'i / 2' == 0 then add, else multiply digit of (% 10) by 2 and add to sum, unless the result > 10, then take the
    // (result less % 10) and (% 10) both and add them to the sum individually.

    long long n = number;
    int sum = 0;
    for (int i = 0; (n > 0); i++)
    {
        int digit = (n % 10);
        if (i % 2 == 0)
            (sum += digit);
        else if (digit * 2 >= 10)
            (sum += ((digit * 2) / 10) + ((digit * 2) % 10));
        else
            (sum += digit * 2);
        n /= 10;
    }
    if (sum % 10 == 0)
        printf("%s\n", brand);
    else
        printf("INVALID\n");
    return 0;
}
