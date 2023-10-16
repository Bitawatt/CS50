# Coleman Liau index == 0.0588 * L - 0.296 * S - 15.8
# where:
#   L == avg#of letters per 100 words
#   S == avg#of sentences per 100 words
""" Counts the number of letter, words, and sentences, and prints as output "Grade X" where `X` is
    the grade level computed by the Coleman-Liau formula, rounded to the nearest integer.
    If the resulting index number is 16 or higher the program outputs `"Grade 16+"`, and likewise,
    if the resulting index number is less than 1, the program outputs `"Before Grade 1"`."""

from cs50 import get_string


def main():
    # Prompt user for text
    text = get_string("Text: ")
    # Call the index function
    index = calculate_index(text)
    # print Grade level
    print(f"{grade_level(index)}")


def calculate_index(text):
    # Count the #of words
    words = len(text.split())
    # Count the #of letters (L)
    L = len([char for char in text if char.isalpha()]) * 100 / words
    # Count the #of sentences (S)
    S = len([char for char in text if char in [".", "!", "?"]]) * 100 / words
    # Calculate index:  0.0588 * L - 0.296 * S - 15.8
    index = round(0.0588 * L - 0.296 * S - 15.8)
    return index


def grade_level(index):
    if index > 16:
        level = "Grade 16+"
    elif index < 1:
        level = "Before Grade 1"
    else:
        level = f"Grade {index}"
    return level


main()
