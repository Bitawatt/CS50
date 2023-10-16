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
    // float result = ((0.0588 * L)-(0.296 * S) - 15.8);
    // printf("L = %f, S = %f\n", L, S);
    // printf("index = %f, int index = %i\n", result, index);

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

// Coleman-Liau formula
// (int) index = 0.0588 * L - 0.296 * S - 15.8
//  where   L = avg# of letters / 100 words,
//  and     S = avg# of sentences / 100 words.
// 'readability' determines reading level,
// assigning a grade level,**"Before Grade 1", 1-16, and 16+,** of a given text.
// As the avg# of letter and words per sentence increases,
// the Coleman-Liau index gives the text a higher reading level.

// Prompt the user for a text using **get-string**
// print the same text with **printf**
// Consider letters to be uppercase or lowercase **alpha. characters**
// no numbers, punctuation, or special chararcters
// below main() a function called "int **count_letter**(string)"
// [hint](https://manual.cs50.io)
// a sentence:
// - will contain at least one word
// - will not start or end with a space
// - will not have multiple spaces in a row
//
// $ ./readability
// Text: ...
// ### letters
// ## words
// # sentences
// Disregard non-sentence ending periods
// Below main() **int count_sentences(string text)**
// Main() outputs only the grade level as defined by Coleman-Liau index