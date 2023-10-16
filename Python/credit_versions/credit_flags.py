from cs50 import get_string
import re


# prompts user for a credit card number and then reports (prints) if valid: {AMEX, MASTERCARD, VISA} or {INVALID}
def main():
    # which brand:
    # Also, AMEX #'s start with 34 or 37 and 15-digits
    # MASTERCARD #'s start with 51, 52, 53, 54, or 55 and have 16-digits
    # VISA #'s start with 4 and have 13, or 16-digits
    # if valid:
    # splice some lists for the luhn's algorithm
    # starting with the second to last digit of the CC#, we multiply it and every other # by '2'.
    # then we add the resulting digits to the digits of the CC# that did not get multiplied, and
    # verify that the result is a modulus of 10 (I think that's how it's said - ends with 0).
    #   *if the total modulo 10 is congruent to 0*

    # prompt user for a credit card number (cc)
    cc = get_string("Number: ")
    # set a 'False' flag
    valid = False
    # do checksum
    # every other digit, starting with cc's second to last digit
    every_other = cc[-2::-2]
    # every other digit, start with cc's last digit
    remaining_digits = cc[-1::-2]
    # multiply ever_other_digit by 2
    every_other_digit = [int(digit) * 2 for digit in every_other]
    # convert every_other_digit to a string, indexing inividual digits
    every_other_digit_str = "".join(map(str, every_other_digit))
    # find sum of every_other_digit_str
    every_other_digit_sum = sum(int(digit) for digit in every_other_digit_str)
    # convert remaining_digits to integers and find the sum
    remaining_digits_sum = sum(int(digit) for digit in remaining_digits)
    # add sums together
    total_sum = every_other_digit_sum + remaining_digits_sum
    # check if total_sum is congruent to )
    if total_sum % 10 == 0:
        # check which brand it is
        valid = True
        if cc[0] == "4" and len(cc) in [13, 16]:
            print("VISA")
        elif cc[0] == "5" and cc[1] in ["1", "2", "3", "4", "5"] and len(cc) == 16:
            print("MASTERCARD")
        elif cc[0] == "3" and cc[1] in ["4", "7"] and len(cc) == 15:
            print("AMEX")
        else:
            valid = False
    if not valid:
        print("INVALID")


main()
