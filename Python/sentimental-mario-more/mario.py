from cs50 import get_int


def main():
    height = get_height()
    for i in range(height):
        print(
            " " * (height - (i + 1)),
            "#" * (height - (height - (i + 1))),
            "  ",
            "#" * (height - (height - (i + 1))),
            sep="",
        )


def get_height():
    while True:
        n = get_int("Height: ")
        if n > 0 and n < 9:
            return n


main()
