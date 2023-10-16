// Implements a dictionary's functionality

#include <ctype.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
} node;

// number of words in the dictionary
unsigned int word_count = 0;

// Choose number of buckets in hash table
// i.e., the length of the array
// Guidelines for a value of N
// If hash function returns a value > N, can take the value, % N, to get a value in appropriate range
// - N => Prime
// - N > 2 * (#of words in "dictionary")
// - N < 4 * (#of words in the "dictionary")
// - ~143,090 words in large dictionary
// - 143,090 * 3 == 429,270
// - closest prime => 429,271
const unsigned long N = 5381;

// Hash table
// an array of node pointers
node *table[N];

// Returns true if word is in dictionary, else false
// - Case insensitive (strcasecmp)
// - Traverse linked list, looking for the word (?cursor?)
bool check(const char *word)
{
    // get the hash value of each word
    unsigned int hash_value = hash(word);

    // access the linked list at that hash_value
    node *index = table[hash_value];

    // compare the word regardless of case at the obtained index
    while (index != NULL)
    {
        if (strcasecmp(index->word, word) == 0)
        {
            return true;
        }
        index = index->next;
    }
    return false;
}

// Hashes word to a number
// - Input: word, with alphabetical characters and (possibly) apostrophes
// - Output: numerical index between 0 and N - 1, inclusive
// - Deterministic

// *** Source *** The below `hash` function is based on the djb2 algorithm.
//  It was originally suggested by GitHub Copilot as a, "a widely-used hash function for strings."
//  It was selected from among 4 analyzed hash functions since the astonishing ratio
//  of simplicity to performance allows the student the delusion that they could have
//  contrived it theirself. The function was amended by the student.
//  Further, the student spends days on these psets, and full Copilot threads (which would
//  comprise hundreds, if not a thousand pages,) can be made available upon request.
//  *being reasonable* - Bitawatt
unsigned int hash(const char *word)
{
    unsigned int hash_value = 0;
    for (int i = 0, n = strlen(word); i < n; i++)
    {
        hash_value = (hash_value << 2) ^ tolower(word[i]);
    }
    return hash_value % N;
}

// Loads dictionary into memory, returning true if successful, else false
// - Open dictionary file
// - Read strings from file one at a time
// - Create a new node for each word
// - Hash word to obtain a hash value
// - Insert node into hash table at that location
bool load(const char *dictionary)
{
    // - Open dictionary file
    FILE *file = fopen(dictionary, "r");
    if (file == NULL)
    {
        unload();
        return false;
    }

    char word[LENGTH + 1];
    // - Read strings from file one at a time
    while (fscanf(file, "%s", word) != EOF)
    {
        // - Create a new node for each word
        node *new_node = malloc(sizeof(node)); // ***
        if (new_node == NULL)
        {
            fclose(file);
            return false;
        }

        // copy the word into a node
        strcpy(new_node->word, word); // ***

        // - Hash word to obtain a hash value
        // determines which linked list the node is inserted to
        int index = hash(word);
        // - Insert node into hash table at that location
        new_node->next = table[index];
        table[index] = new_node;

        // increment word count
        word_count++;
    }

    fclose(file);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // // traverse linked list, counting nodes
    // int count = 0;

    // for (unsigned long i = 0; i < N; i++)
    // {
    //     node *index = table[i];
    //     while (index != NULL)
    //     {
    //         count++;
    //         index = index->next;
    //     }
    // }
    return word_count;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // free memory at each node
    for (int i = 0; i < N; i++)
    {
        node *index = table[i];
        while (index != NULL)
        {
            node *temp = index;
            index = index->next;
            free(temp);
        }
    }

    // free memory for the hash table
    // free(table);
    return true;
}

// long closest_prime(void)
// {
//     long n = 3 * word_count;

//     if (is_prime(n))
//     {
//         return n;
//     }

//     long less = n - 1;
//     long more = n + 1;

//     while (true)
//     {
//         if (is_prime(less))
//         {
//             return less;
//         }
//         else if (is_prime(more))
//         {
//             return more;
//         }

//         less--;
//         more++;
//     }
// }

// bool is_prime(long n)
// {
//     if (n <= 1)
//     {
//         return false;
//     }

//     for (long i = 2; i <= sqrt(n); i++)
//     {
//         if (n % i == 0)
//         {
//             return false;
//         }
//     }

//     return true;
// }