#include <cs50.h>
#include <stdio.h>

int main(void)
{
    long long number;
    int length;
    char *brand;

    do
    {
        number = get_long_long("Number: ");

        length = 0;
        // Check length
        for (long n = number; n != 0; n /=10)
        {
            length++;
        }
        // printf("%i\n", length);

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
    } while (brand == NULL);

    // Verify Checksum
        // number / 10 get Remainder '%'; increment process with 'i' followed by an 'if':
        // if 'i / 2' == 0 then add, else multiply digits by 2 and add: if result / 10 != 0 then multiply 2 \n
        // result less % and % both, then add. add the sum of digits multiply by to to sum of digit not multiplied by 2.
    long long n = number;
    int sum = 0;
    for (int i = 0; (n > 0); i++)
    {
        if (i % 2 == 0)
            (sum += (n % 10));
        else if ((n % 10) * 2 >= 10)
            (sum += (((n % 10) * 2) / 10) + (((n % 10) * 2) % 10));
        else
            (sum += (n % 10) * 2);
        n = (n / 10);
        // printf("%i, %i, %lli, %lli\n", i, sum, (n % 10), n);
    }
    if (sum % 10 == 0)
        printf("%s\n", brand);
    else
        printf("INVALID\n");
}
    // Check length (no cards start with '0', so # of digits = size of #)
    // Checksum
    // Check Brand
    // If all are true return: "Valid", number and brand

    //operators in C:

    // - `+=`: Add and assign. `a += 2` is equivalent to `a = a + 2`.
    // - `-=`: Subtract and assign. `a -= 2` is equivalent to `a = a - 2`.
    // - `*=`: Multiply and assign. `a *= 2` is equivalent to `a = a * 2`.
    // - `%=`: Modulo and assign. `a %= 2` is equivalent to `a = a % 2`.
