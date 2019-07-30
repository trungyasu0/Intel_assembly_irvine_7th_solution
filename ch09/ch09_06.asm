TITLE Chapter 9 Exercise 6              (ch09_06.asm)

Comment !
Description: Write a procedure named Get_frequencies that constructs
a character frequency table. Input to the procedure should be a
pointer to a string, and a pointer to an array of 256 doublewords.
Each array position is indexed by its corresponding ASCII code. When
the procedure returns, each entry in the array contains a count of how
many times that character occurred in the string.

Difficulty level: 3/5
Last update: 10/30/02
!
INCLUDE Irvine32.inc

Get_frequencies PROTO,
	pString:PTR BYTE,	; points to string
	pTable:PTR DWORD	; points to frequencey table

.data
freqTable DWORD 256 DUP(0)
;aString BYTE 1,2,"THE QUICK BROWN FOX JUMPED OVER THE LAZY DOGS BACK",0

aString BYTE 80 DUP(0),0

str1 BYTE "*** Constructing a Frequency Table *** (DEMO)",
	0dh,0ah,0dh,0ah,
	"Enter between 1 and 80 characters: ",0

.code
main PROC

	call Clrscr
	mov  edx,OFFSET str1
	call WriteString

	mov  ecx,SIZEOF aString - 1
	mov  edx,OFFSET aString
	call ReadString

	INVOKE Get_frequencies, ADDR aString, ADDR freqTable
	call DisplayTable

	exit
main ENDP

;-------------------------------------------------------------
Get_frequencies PROC,
	pString:PTR BYTE,	; points to string
	pTable:PTR DWORD	; points to frequencey table
;
; Constructs a character frequency table. Each array position
; is indexed by its corresponding ASCII code.
;
; Returns: Each entry in the table contains a count of how
; many times that character occurred in the string.
;-------------------------------------------------------------

	mov esi,pString
	mov edi,pTable
	cld		; clear Direction flag (forward)

L1:	mov eax,0		; clear upper bits of EAX
	lodsb		; AL = [ESI], inc ESI
	cmp al,0		; end of string?
	je  Exit_proc		; yes: exit
	shl eax,2		; multiply by 4
	inc DWORD PTR [edi + eax]	; inc table[AL]
	jmp L1		; repeat loop

Exit_proc:
	ret
Get_frequencies ENDP

;-------------------------------------------------------------
DisplayTable PROC
;
; Display the non-empty entries of the frequency table.
; This procedure was not required, but it makes it easier
; to demonstrate that Get_frequencies works.
;-------------------------------------------------------------
.data
colonStr BYTE ": ",0
.code
	call Crlf
	mov ecx,LENGTHOF freqTable	; entries to show
	mov esi,OFFSET freqTable
	mov ebx,0	; index counter

L1:	mov eax,[esi]	; get frequency count
	cmp eax,0	; count = 0?
	jna L2	; if so, skip to next entry

	mov eax,ebx	; display the index
	call WriteChar
	mov edx,OFFSET colonStr	; display ": "
	call WriteString
	mov eax,[esi]	; show frequency count
	call WriteDec
	call Crlf

L2:	add esi,TYPE freqTable	; point to next table entry
	inc ebx	; increment index
	loop L1

	call Crlf
	ret
DisplayTable ENDP

END main