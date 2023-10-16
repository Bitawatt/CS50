#include <cs50.h>
#include <stdio.h>
#include <string.h>

// Max number of candidates
#define MAX 9

// preferences[i][j] is number of voters who prefer i over j
int preferences[MAX][MAX];

// locked[i][j] means i is locked in over j
bool locked[MAX][MAX];

// Each pair has a winner, loser
typedef struct
{
    int winner;
    int loser;
} pair;

// Array of candidates
string candidates[MAX];
pair pairs[MAX * (MAX - 1) / 2];

int pair_count;
int candidate_count;

// Function prototypes
bool vote(int rank, string name, int ranks[]);
void record_preferences(int ranks[]);
void add_pairs(void);
void sort_pairs(void);
void lock_pairs(void);
bool creates_cycle(int winner, int loser);
void print_winner(void);

int main(int argc, string argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: tideman [candidate ...]\n");
        return 1;
    }

    // Populate array of candidates
    candidate_count = argc - 1;
    if (candidate_count > MAX)
    {
        printf("Maximum number of candidates is %i\n", MAX);
        return 2;
    }
    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i] = argv[i + 1];
    }

    // Clear graph of locked in pairs
    for (int i = 0; i < candidate_count; i++)
    {
        for (int j = 0; j < candidate_count; j++)
        {
            locked[i][j] = false;
        }
    }

    pair_count = 0;
    int voter_count = get_int("Number of voters: ");

    // Query for votes
    for (int i = 0; i < voter_count; i++)
    {
        // ranks[i] is voter's ith preference
        int ranks[candidate_count];

        // Query for each rank
        for (int j = 0; j < candidate_count; j++)
        {
            string name = get_string("Rank %i: ", j + 1);

            if (!vote(j, name, ranks))
            {
                printf("Invalid vote.\n");
                return 3;
            }
        }

        record_preferences(ranks);

        printf("\n");
    }

    add_pairs();
    sort_pairs();
    lock_pairs();
    print_winner();
    return 0;
}

// Update ranks given a new vote
bool vote(int rank, string name, int ranks[])
{
    for (int i = 0; i < candidate_count; i++)
    {                                         // Compare the string (char*), name, from 'get_string()'
        if (strcmp(name, candidates[i]) == 0) // to the string from argv[i], candidates[i].
        {                                     // The indeces of the candidates[] array `i` stored
            ranks[rank] = i;                  // at index `j`, f/loop in main(), in the `ranks[]` array.
            return true;                      // true if valid name, valid vote
        }
    }
    return false;
}

// Update preferences given one voter's ranks
void record_preferences(int ranks[]) // record the #of voters who prefer candidate[i]
{                                    // to candidate[j]
    for (int i = 0; i < candidate_count; i++)
    {
        for (int j = (i + 1); j < candidate_count; j++)
        {
            preferences[ranks[i]][ranks[j]]++; // update the global `preferences[i][j]` array
        }
    }
}

// Record pairs of candidates where one is preferred over the other
void add_pairs(void)
{
    for (int i = 0; i < candidate_count; i++) 
    {
        for (int j = (i + 1); j < candidate_count; j++) // loop through preferences[i][j]
        {                                               // testing conditions > & <
            if (preferences[i][j] > preferences[j][i])
            {
                pairs[pair_count].winner = i; // update struct of each pair[0++]
                pairs[pair_count].loser = j;
            pair_count++;                     // increment pair_count
            }
            else if (preferences[i][j] < preferences[j][i])
            {
                pairs[pair_count].winner = j;
                pairs[pair_count].loser = i;
                pair_count++;
            }
        }
    }
    return;
}

// Sort pairs in decreasing order by strength of victory
void sort_pairs(void)
{
    for (int i = 0; i < pair_count; i++) // loop through preferences for pairs
    {
        for (int j = (i + 1); j < candidate_count; j++)
        {
            if (preferences[pairs[i].winner][pairs[i].loser] < preferences[pairs[j].winner][pairs[j].loser])
            {
                pair temp = pairs[i];
                pairs[i] = pairs[j];
                pairs[j] = temp;
            }
        }
    }
    return;
}

// Lock pairs into the candidate graph in order, without creating cycles
void lock_pairs(void)
{
    // set all `locks` to false
    for (int i = 0; i < candidate_count; i++)
    {
        for (int j = 0; j < candidate_count; j++)
        {
            locked[i][j] = false;
        }
    }

    // loop through `pairs[]` array in decreasing order of strength of victory
    for (int i = 0; i < pair_count; i++)
    {
        // check if adding `pair` to locked graph will create a cycle
        if (!creates_cycle(pairs[i].winner, pairs[i].loser))
        {
            locked[pairs[i].winner][pairs[i].loser] = true; // add the edge to the graph
        }
    }
}

bool creates_cycle(int winner, int loser)
{
    if (winner == loser)
    {
        return true;
    }
    for (int i = 0; i < candidate_count; i++)
    {
        if (locked[loser][i])
        {
            if (creates_cycle(winner, i))
            {
                return true;
            }
        }
    }
    return false;
}
// Print the winner of the election
void print_winner(void)
{
    // loop through all candidates
    for (int i = 0; i < candidate_count; i++)
    {
        bool is_source = true;

        // check if each candidate is source of `locked` graph
        for (int j = 0; j < candidate_count; j++)
        {
            if (locked[j][i])
            {
                is_source = false;
                break;
            }
        }

        // print candidate if they are the source of the `locked` graph
        if (is_source)
        {
            printf("%s\n", candidates[i]);
        }
    }
    return;
}