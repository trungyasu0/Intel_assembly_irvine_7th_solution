include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 

Str_trim_leading PROTO,
	pString:PTR BYTE,		; points to string
	char:BYTE				; character to remove

Str_remove PROTO ,
	pStart:PTR byte,		
	nChars: DWORD
	
Str_length PROTO,
	pString:PTR BYTE		; pointer to string


.data
; Test data:
string_3 BYTE "####Hello###",0	; case 3

.code
main PROC
	call Clrscr
	INVOKE Str_trim_leading,ADDR string_3,'#'
	mov 	edx, OFFSET string_3
	call	WriteString

	exit
main ENDP

;-----------------------------------------------------------
Str_trim_leading PROC USES eax ebx edi ecx,
 pString:PTR BYTE,
 char:BYTE
;-----------------------------------------------------------
	INVOKE 	Str_length, pString
	mov 	ecx, eax 				; ecx = string_length 
	mov 	edi, pString 			; edi point to string 
	mov 	eax, 0 					; initilize eax = 0
Find_loop:
	mov 	bl, [edi] 
	cmp 	bl, char 
	jnz 	fin 
	inc 	eax 
	inc 	edi 
	loop	Find_loop
fin:
	INVOKE	Str_remove, pString, eax 
	ret
Str_trim_leading ENDP
;-----------------------------------------------------------
Str_remove PROC,
	pStart:PTR BYTE,	; points to first character to delete
	nChars:DWORD	; number of characters to delete

	INVOKE Str_length,pStart				;
	mov ecx,eax						; ECX = length of string

	cmp 	nChars, ecx 			; if nChars <= ecx -> ecx = ecx - nChars 
	jg		L1
	sub 	ecx, nChars
	
L1:	mov 	esi,pStart				; points to string
	add 	esi,nChars				; points to first character to copy
	mov 	edi,pStart				; points to destination position

	cld								; clear direction flag (forward)
	rep 	movsb					; do the move
	mov 	BYTE PTR [edi],0		; insert new null byte

	ret
Str_remove ENDP

END main
