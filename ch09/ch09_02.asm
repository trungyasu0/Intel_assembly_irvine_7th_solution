TITLE Chapter 9 Exercise 2              (ch09_02.asm)

Comment !
Description: Write a procedure named Str_concat that concatenates a
source string to the end of a target string. Sufficient space must
be available in the target string before this procedure is called.
Pass pointers to the source and target strings.

Difficulty level: 2/5


INCLUDE Irvine32.inc

Str_concat PROTO,
 	source:PTR BYTE, 		; source string
 	target:PTR BYTE		; target string

.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0

.code
main PROC
	call Clrscr

	; Sample procedure call
	INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

	; Display the target string
	mov  edx,OFFSET targetStr
	call WriteString
	call Crlf

	exit
main ENDP

;---------------------------------------------------------
Str_concat PROC USES eax ecx esi edi,
 	target:PTR BYTE, 		; source string
 	source:PTR BYTE		; target string
;
; Copy a string from source to target.
; Requires: the target string must contain enough
;           space to hold a copy of the source string.
;----------------------------------------------------------
	INVOKE Str_length,target		; get length of target string
	add target,eax		; move to end of target string
	INVOKE Str_length,source 	; get length of source string
	mov ecx,eax		; insert length in REP count
	inc ecx         		; add 1 for null byte
	mov esi,source
	mov edi,target
	cld               		; direction = up
	rep movsb      		; copy the string
	ret
Str_concat ENDP

END main