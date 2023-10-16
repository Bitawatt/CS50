# Simulate a sports tournament

import csv
import random
import sys

# Number of simluations to run
N = 1000


def main():
    # Ensure correct usage
    if len(sys.argv) != 2:
        sys.exit("Usage: python tournament.py FILENAME")

    teams = []
    # Read teams into memory from file
    with open(sys.argv[1]) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            # convert the team's rating to an `int`
            row["rating"] = int(row["rating"])
            # ultimately, append each team's dictionary to `teams`
            teams.append(row)

    counts = {}
    # Simulate N tournaments and keep track of win counts
    for i in range(N):
        winner = simulate_tournament(teams)
        if winner in counts:
            counts[winner] += 1
        else:
            counts[winner] = 1

    # Print each team's chances of winning, according to simulation
    for team in sorted(counts, key=lambda team: counts[team], reverse=True):
        print(f"{team}: {counts[team] * 100 / N:.1f}% chance of winning")

    # Print the number of simulations, N
    print(f"\nrunning {N} simulations")


def simulate_game(team1, team2):
    """Simulate a game. Return True if team1 wins, False otherwise."""
    rating1 = team1["rating"]
    rating2 = team2["rating"]
    probability = 1 / (1 + 10 ** ((rating2 - rating1) / 600))
    return random.random() < probability


def simulate_round(teams):
    """Simulate a round. Return a list of winning teams."""
    winners = []

    # Simulate games for all pairs of teams
    for i in range(0, len(teams), 2):  # `range(start, stop, step)`
        if simulate_game(teams[i], teams[i + 1]):
            winners.append(teams[i])
        else:
            winners.append(teams[i + 1])

    return winners


def simulate_tournament(teams):
    """Simulate a tournament. Return name of winning team."""
    # input a list of teams *and just set them equal to `winners` to simplify the loop*
    # repeatedly simulates rounds until only one team remains
    #   - loops `simulate_round`
    #       - returns the name of that team
    #       - returns a list of all of the winners
    # use `len(x)` to determine the length of the list
    winners = teams
    while len(winners) > 1:
        winners = simulate_round(winners)
    return winners[0]["team"]


if __name__ == "__main__":
    main()
