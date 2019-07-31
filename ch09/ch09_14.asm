include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 

Str_trim_filter PROTO, 
	pString:PTR BYTE

.data
; Test data:
string_3 BYTE "ABC#$&#",0	; case 3

.code
main PROC
	call Clrscr
	INVOKE Str_trim_filter,ADDR string_3
	mov 	edx, OFFSET string_3
	call	WriteString

	exit
main ENDP

;-----------------------------------------------------------
Str_trim_filter PROC uses ecx,
 pString:PTR BYTE
;-----------------------------------------------------------
	INVOKE 	Str_length, pString	
	mov 	ecx, eax				;ecx = length string
Loop_filer:	
	INVOKE 	Str_trim, pString, '%'
	INVOKE 	Str_trim, pString, '#'
	INVOKE 	Str_trim, pString, '!'
	INVOKE 	Str_trim, pString, ';'
	INVOKE 	Str_trim, pString, '$'
	INVOKE 	Str_trim, pString, '&'
	INVOKE 	Str_trim, pString, '*'
	loop	Loop_filer
	ret
Str_trim_filter ENDP
end main
