# CS50/pset/3/runoff
- simulates a runoff election
- **ToDo**
    - complete the following functions
- not ToDo
    - alter the existing code except adding relevant header files

## Candidate Struct
- string name
- int votes
- bool eliminated

## Global Arrays
- candidate candidates[]
- so:
    - candidates[].name
    - candidates[].votes
    - candidates[].eliminated (true || false)

## Global Variables
- int voter_count
- int candidate_count

## functions
- bool vote(int voter, int rank, string name)
- void tabulate(void)
- bool print_winner(void)
- int find_min(void)
- bool is_tie(int min)
- void eliminate(int min)

## vote()
- keeps track of all preferences for all voters

### calling function

```c
 for (int i = 0; i < voter_count; i++)
    {

        // Query for each rank
        for (int j = 0; j < candidate_count; j++)
        {
            string name = get_string("Rank %i: ", j + 1);

            // Record vote, unless it's invalid
            if (!vote(i, j, name))
            {
                printf("Invalid vote.\n");
                return 4;
            }
        }

        printf("\n");
    }
```

### req's
- Args
    - `voter` // voter == `i` from calling function
    - `rank` // rank == `j` from calling function
    - `name`
- If `name` matches a candidate (no 2 candidates will have the same name)
    - update global preferences array that
        - `voter` has that candidate as their `rank` preference
    - We'll be using `strcmp()` to compare strings
- '0' is the first preference
- '1' is the second preference, etc.
### hints
- `candidate_count` stores the number of candidates in the election
- use `strcmp()` to compare two strings
- `preferences[i][j] stores the index of the candidate who is the `j`th ranked preference for the `i`th voter

### psuedocode
- for all the candidates
    - If 0 difference when comparing `name` to candidates[k].name
        - update preferences[i][j] to reflect index of candidate[k]
        - return true

## tabulate ()
- looks at all the voters' preferences and computes the current vote totals
- looks at each voter's top choice candidate who hasn't been eliminated
### req's
- the function should update the #of `votes` each candidate has at this stage of the runoff.
- at each stage in the runoff, every voter effectively votes for their top-preferred cnadidate who has not been eliminated
### hints
- `voter_count` stores the number of voters in the election and that, for each voter, we count one ballot
- voter `i` has their top choice represented by `preferences[i][0]`, and their second by `preferences[i][1]
- `candidate``struct` has a field called `eliminated`, which will be `true` if the candidate has been eliminated form the election
` `candidate``struct` has a field called `votes`, that should be updated for each voter's preferred candidate
- Once the voter's vote for the first non-eliminated candidate is cast - stop
    - `break` out fo loop
### psuedocode
- for all of the voters non-eliminated top preference
    - if preferences[i][j] is not eliminated ==>> candidates[preferences[i][j]].eliminated == false
        - update the votes thaat candidate has, ==>> candidates[preferences[i][j]].votes++

## print_winner()
- prints out the winner
- if there is one
    - the program ends
### req's
- true/false
- if winner (more than half of the total votes)
    - true
- if not false
### psuedocode
- if any candidate has > voter_count / 2
    - winner = true
- else
    - winner = false

## find_min()
- determines the fewest number of votes for any candidate(s) still in the election
### req's
- return the minimum vote total for any candidate still in the election

### psuedocode
- keep track of minimum vote (int min)
- loop through candidates
- if candidates[i].eliminated == false
    - if candidates[i].votes < min
        - min == candidates[i].votes
- return min
## is_tie()
- determines if **all** candidates have the same number of votes
- if so
    - "tie" - the program ends
### req's
- input: min
- output: true/false
### psuedocode
- loop through candidates
- if any candidates[i] is not equal to min
    - return true
- else return false
## eliminate()
- eliminates from the election the candidate(s) with the fewest votes
    - sounds like it's going to rely on `find_min`
### req's
- input: min
- eliminate candidates[i] whose candidates[i].votes == min
### psuedocode
- loop through the candidates
- if candidates[i].votes == min
    - candidates[i].eliminated = true