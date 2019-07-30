TITLE Chapter 9 Exercise 1              (ch09_01.asm)

Comment !
Description: The Str_copy procedure shown in this chapter does not limit
the number of characters to be copied. Create a new version (named Str_copyN)
that requires an additional input parameter indicating the maximum number
of characters to be copied.

Difficulty level: 1/5


INCLUDE Irvine32.inc

Str_copyN PROTO,
 	source:PTR BYTE, 	; source string
 	target:PTR BYTE,	; target string
 	maxChars:DWORD	; max chars to copy

.data
string_1 BYTE "ABCDEFGABCDEFGABCDEFGABCDEFG",0
string_2 BYTE 20 DUP(?),0

.code
main PROC
	call Clrscr

	INVOKE Str_copyN,		; copy string_1 to string_2
	  ADDR string_1,
	  ADDR string_2,
	  (SIZEOF string_2) - 1		; save space for null byte

; Display the destination string
	mov  edx,OFFSET string_2
	call WriteString
	call Crlf

	exit
main ENDP

;---------------------------------------------------------
Str_copyN PROC USES eax ecx esi edi,
 	source:PTR BYTE, 		; source string
 	target:PTR BYTE,		; target string
 	maxChars:DWORD		; max chars to copy
;
; Copy a string from source to target, limiting the number
; of characters to copy. Value in maxChars does not include
; the null byte.
;----------------------------------------------------------
	mov ecx,maxChars		; specify count for REP
	mov esi,source
	mov edi,target
	cld               		; direction = forward
	rep movsb      		; copy the string
	mov al,0
	stosb		; append null byte
	ret
Str_copyN ENDP

END main