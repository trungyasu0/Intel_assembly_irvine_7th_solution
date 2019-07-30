TITLE Chapter 9 Exercise 3              (ch09_03.asm)

Comment !
Description: Write a procedure named Str_remove that removes n characters
from a string. Pass a pointer to the position in the string where the
characters are to be removed. Pass an integer specifying the number of
characters to remove.

Difficulty level: 3/5


INCLUDE Irvine32.inc

Str_remove PROTO,
	pStart:PTR BYTE,
	nChars:DWORD

.data
target BYTE "abcdefghijklmnop",0

.code
main PROC

	INVOKE Str_remove, ADDR target, 1
	mov edx,OFFSET target
	call WriteString
	call Crlf

	INVOKE Str_remove, ADDR target + 2, 2
	mov edx,OFFSET target
	call WriteString
	call Crlf

	INVOKE Str_remove, ADDR target + 2, 19		; nChars too large
	mov edx,OFFSET target
	call WriteString
	call Crlf

	exit
main ENDP

;-------------------------------------------------------
Str_remove PROC,
	pStart:PTR BYTE,	; points to first character to delete
	nChars:DWORD	; number of characters to delete
;
; Removes a block of characters from a string. The
; algorithm involves skipping over the positions that
; will be deleted, and copying the remaining characters
; backward. Each copied character overwrites one of the
; deleted positions. If nChars is too large, all remaining
; characters in the string will be removed.
;-------------------------------------------------------

	INVOKE Str_length,	; get string length
	  pStart	; points to start of string
	mov ecx,eax	; ECX = length of string

	.IF nChars <= ecx	; check range of nChars
	  sub ecx,nChars	; set counter for REP prefix
	.ENDIF

	mov esi,pStart	; points to string
	add esi,nChars	; points to first character to copy
	mov edi,pStart	; points to destination position

	cld	; clear direction flag (forward)
	rep movsb	; do the move
	mov BYTE PTR [edi],0	; insert new null byte

Exit_proc:
	ret
Str_remove ENDP


END main