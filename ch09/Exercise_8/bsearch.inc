; Bsearch.inc - prototypes for procedures used in
; the BubbleSort program.

; Fill an array with 32-bit signed random integers
FillArray PROTO,
	pArray:PTR DWORD,		; pointer to array
	Count:DWORD,		; number of elements
	LowerRange:SDWORD,		; lower range
	UpperRange:SDWORD		; upper range

; Write a 32-bit signed integer array to standard output
PrintArray PROTO,
	pArray:PTR DWORD,
	Count:DWORD

; Sort the array in ascending order
BubbleSort PROTO,
	pArray:PTR DWORD,
	Count:DWORD