#include <cs50.h>
#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

int count_letters(string text);
int count_words(string text);
int count_sentences(string text);

int main(void)
{
    string text = get_string("Text: ");

    printf("\n%i letters\n", count_letters(text));
    printf("%i words\n", count_words(text));
    printf("%i sentences\n", count_sentences(text));

    // Calculate Coleman-Liau index
    float L = (count_letters(text) * 100.0 / count_words(text));   // L = avg# of Letters / 100 words
    float S = (count_sentences(text) * 100.0 / count_words(text)); // S = avg# of Sentences / 100 words
    int index = round((0.0588 * L) - (0.296 * S) - 15.8);

    if (index < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (index > 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %i\n", index);
    }

    return 0;
}

int count_letters(string text)
{
    int count_letters = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if (isalpha(text[i]))
        {
            count_letters++;
        }
    }
    return count_letters;
}

int count_words(string text)
{
    int count_words = 1;
    for (int i = 0; i < strlen(text); i++)
    {
        if (isspace(text[i]))
        {
            count_words++;
        }
    }
    return count_words;
}

int count_sentences(string text)
{
    int count_sentences = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if (text[i] == '.' || text[i] == '!' || text[i] == '?')
        {
            count_sentences++;
        }
    }
    return count_sentences;
}
