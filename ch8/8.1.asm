include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 


FindLargest PROTO,
	ptrSDWORDArray: PTR SDWORD, 	; points to the array
	arraySize: DWORD		; size of array



.data
array1	sdword	0,0,0,10,1,53,51,-12,-124,54,1235

text	byte	"The largest value in array is: ", 0

.data?
largest sdword	?

.code

main proc
	call	Clrscr

	INVOKE	FindLargest, ADDR array1, LENGTHOF array1
	mov	largest, eax

	;display refult

	mov	edx, OFFSET text
	call	WriteString
	call	WriteInt
	call	Crlf

	exit
main endp



;------------------------------------------------------------------
FindLargest proc,
	ptrSDWORDArray: PTR SDWORD,	;point to array
	arraySize: DWORD		;size array

;find largest element in the array
;retunr result in eax
	push	ecx
	push	esi

	mov	esi,ptrSDWORDArray
	mov	eax, [esi]		;set first element is max 
	add	esi, 4			;next
	mov	ecx, arraySize		;counter
	dec	ecx

ScanArray:
	mov	ebx, DWORD PTR [esi]
	cmp	ebx, eax
	jle	NotGreater		; if not greater -> next 
	mov	eax, ebx	
NotGreater:
	add	esi, 4			; next
	loop	ScanArray

	pop	esi
	pop	ecx
	ret
FindLargest endp


end main
