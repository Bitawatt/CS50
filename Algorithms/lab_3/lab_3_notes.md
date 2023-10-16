# Lab_3_Notes
- Use the 'mystery' sort files to determine the algorithm they utilize

## 3-Different Algorithms
- Selection Sort
- Bubble Sort
- Merge Sort

## Big-O Running Time
- Bubble Sort
    - random RT     - n^2
    - Big-Omega RT  - n
        - Much faster on a sorted file
        - Therefore, probably `sort1`
- Selection Sort
    - random RT     - n^2
    - Big-Omega RT  -
    - By deduction
        - probably `sort3`
- Merge Sort
    - random RT - n*log(n)
        - Merge Sort is going to be significantly faster the (n^2) sorts
        - Therefore, probably `sort2`
##
## Data Set
- Real Time Table (ms)
| Type of Sort | sort1 | sort2 | sort3 |
|--------------|-------|-------|-------|
| random5000    |  73   |  19   |   52  |
| random10000   | 208   |  55   |  144  |
| random50000   | 6,727 | 1,170 | 2,645 |
| reversed5000  |  87   |  18   |   44  |
| reversed10000 | 217   |  58   |  131  |
| reversed50000 | 5,788 | 1,622 | 3,482 |
| sorted5000    |  36   |  37   |   47  |
| sorted10000   |  67   |  52   |  116  |
| sorted50000   | 1,612 | 1,332 | 3,380 |

- random5000
    - sort1
    - sort2
    - sort3
- random10000
    - sort1
    - sort2
    - sort3
- random50000
    - sort1
    - sort2
    - sort3
- reversed5000
    - sort1
    - sort2
    - sort3
- reversed10000
    - sort1
    - sort2
    - sort3
- reversed50000
    - sort1
    - sort2
    - sort3
- sorted5000
    - sort1
    - sort2
    - sort3
- sorted10000
    - sort1
    - sort2
    - sort3
- sorted50000
    - sort1
    - sort2
    - sort3