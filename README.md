# CS314 PRINCIPLES OF PROGRAMMING PROJECTS
By Meesun Park

## Description
Rutgers CS314 Spring 2016 Data Structures Assignment. (JAVA) Program requests for graph input file with menu. Program runs shortest path between two friends as well as any adjacent friends.

## Try to Use:
## Project 1: Scheme
Program was written in Scheme.
The program append-col, append-rows, flip-cols, and flip-rows for different patterns.
Assignment instructions to define append-col, append-rows, flip-cols, flip-rows, repeat-rows, range-check
Example Execution:
> (for-n 2 4 (lambda (n) (display n) (+ n 10)))
234(12 13 14)
> (define pa (charpat #\a))

> (define pb (charpat #\b))

> (define ab (append-cols pa pb))

> (define cde (append-cols (charpat #\c)(append-cols (charpat #\d)(charpat #\e))))

> (define abcd (append-rows  ab cde))

> (display-window 0 0 0 0 pa)
a

> (display-window 0 0 0 1 pa)
a.

> (display-window 0 1 0 1 pa)
a.
..

> (display-window 0 1 0 1 ab)
ab
..

> (display-window 0 2 0 2 abcd) ; note that cde gets truncated to 2 columns
; because ab has only 2 columns
ab.
cd.
...

> (display-window 0 1 0 2 cde)
cde
...

> (display-window 0 3 0 3 (sw-corner 4))
*
**
***
****

> (display-window 0 3 0 3 (flip-rows(sw-corner 4)))
****
***
**
*

> (display-window 0 3 0 3 (flip-cols(sw-corner 4)))
ooo*
oo**
o***
****

> (let ((p1 (append-rows ab (flip-cols ab))))
    (display-window 0 2 0 4 (append-cols p1 (flip-rows p1))))
abba.
baab.
.....


## Project 2: Prolog
Program written in Prolog.
Stimulates a Deterministic & Non-Deterministic Finite State with letting you know if it is a proper finite state or not.
Assignment instructions to define state_struct, next_state_name, and accepts

## Project 3: Python
Program written in Python.
Program created histogram of users usage of printers.
Assignment instructions to define log2hist function
