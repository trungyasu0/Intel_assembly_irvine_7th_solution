TITLE Chapter 9 Exercise 5                     (ch09_05.asm)

Comment !
Description: Write a procedure called Str_nextword that scans a string
for the first occurrence of a certain delimiter character and replaces
the delimiter with a null byte. There are two input parameters: a
pointer to the string, and the delimiter character. After the call,
if the delimiter was found, the Zero flag is set and EAX contains the
offset of the next character beyond the delimiter. Otherwise, the Zero
flag is clear. For example, we can pass the address of target and a
comma as the delimiter:

Difficulty level: 3/5

INCLUDE Irvine32.inc

Str_nextword PROTO,
	pString:PTR BYTE,	; pointer to string
	delimiter:BYTE	; delimiter to find

.data
testStr BYTE "ABC\DE\FGHIJK\LM",0

.code
main PROC
	call Clrscr
	mov  edx,OFFSET testStr		; display starting string
	call WriteString
	call Crlf

; Loop through the string, replace each delimiter, and
; display the remaining string.

	mov esi,OFFSET testStr
L1:	INVOKE Str_nextword, esi, "\"	; look for delimiter
	jnz Exit_prog		; quit if not found
	mov esi,eax		; point to next substring
	mov edx,eax
	call WriteString		; display remainder of string
	call Crlf
	jmp L1

Exit_prog:
	exit
main ENDP

;---------------------------------------------------------------
Str_nextword PROC,
	pString:PTR BYTE,	; pointer to string
	delimiter:BYTE	; delimiter to find
;
; Scans a string for the first occurrence of a certain delimiter
; character and replaces the delimiter with a null byte.
; Returns: If ZF = 1, the delimiter was found and EAX contains
;   the offset of the next character beyond the delimiter.
;   Otherwise, ZF = 0 and EAX is undefined.
;---------------------------------------------------------------

	push esi
	mov  al,delimiter
	mov  esi,pString
	cld	; clear Direction flag (forward)

L1:	lodsb	; AL = [esi], inc(esi)
	cmp al,0	; end of string?
	je  L3	; yes: exit with ZF = 0
	cmp al,delimiter	; delimiter found?
	jne L1	; no: repeat loop

L2:	mov BYTE PTR [esi-1],0	; yes: insert null byte
	mov eax,esi	; point EAX to next character
	jmp Exit_proc	; exit with ZF = 1

L3: or al,1	; clear Zero flag

Exit_proc:
	pop esi
	ret
Str_nextword ENDP

END main