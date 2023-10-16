#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

// Points assigned to each letter of the alphabet
int POINTS[] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};
char LETTERS[] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};

int compute_score(string word);

int main(void)
{
    // Get input words from both players
    string word1 = get_string("Player 1: ");
    string word2 = get_string("Player 2: ");

    // Score both words
    int score1 = compute_score(word1);
    int score2 = compute_score(word2);

    // TODO: Print the winner
    if (score1 > score2)
        printf("Player 1 Wins!\n");
    else if (score1 < score2)
        printf("Player 2 Wins!\n");
    else
        printf("Tie!\n");
}

int compute_score(string word)
{
    // TODO: Compute and return score for string
    // make uppercase and remove non-letters

    int score = 0;
    char UPR_case_word[strlen(word) + 1];

    int j = 0;
    for (int i = 0; word[i] != '\0'; i++)
    {
        if (isalpha(word[i]))
        {
            UPR_case_word[j] = toupper(word[i]);
            j++;
        }
    }
    UPR_case_word[j] = '\0';

    for (int i = 0; UPR_case_word[i] != '\0'; i++)
    {
        for (int k = 0; k < sizeof(LETTERS); k++)
        {
            if (LETTERS[k] == UPR_case_word[i])
            {
                score += POINTS[k];
            }
        }
    }
    return score;
}

// Iterate through word*[] until word*[i] matches LETTERS[i] then get and add POINTS[i] to score