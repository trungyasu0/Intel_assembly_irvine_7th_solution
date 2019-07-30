TITLE Chapter 9 Exercise 8              (ch09_08.asm)

Comment !
Description: Add a variable to the BubbleSort procedure in Section
9.5.1 that is set to 1 whenever a pair of values is exchanged within
the inner loop. Use this variable to exit the sort before its normal
completion if you discover that no exchanges took place during a
complete pass through the array. (This variable is commonly known
as an exchange flag.)

Difficulty level: 1/5


INCLUDE Irvine32.inc
INCLUDE Bsearch.inc	; procedure prototypes

LOWVAL = -5000	; minimum value
HIGHVAL = +5000	; maximum value
ARRAY_SIZE = 50	; size of the array

.data
array DWORD ARRAY_SIZE DUP(?)

.code
main PROC
	call Randomize

	; Fill an array with random signed integers
	INVOKE FillArray, ADDR array, ARRAY_SIZE, LOWVAL, HIGHVAL

	; Perform a bubble sort
	INVOKE BubbleSort, ADDR array, ARRAY_SIZE

	; Sort the array again to test the exchange flag
	INVOKE BubbleSort, ADDR array, ARRAY_SIZE

	; Display the array
	INVOKE PrintArray, ADDR array, ARRAY_SIZE

	exit
main ENDP

END main