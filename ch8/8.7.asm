include \Irvine\Irvine32.inc 
includelib \Irvine\Irvine32.lib
includelib \Irvine\Kernel32.lib
includelib \Irvine\User32.lib 

CalcGcd PROTO,int1:DWORD, int2:DWORD

.data
array SDWORD 5,20,24,18,11,7,438,226,26,13
str1 BYTE "Greatest common divisor is: ",0

.code
main PROC

	mov  ecx,LENGTHOF array / 2
	mov  esi,OFFSET array

L1:	INVOKE CalcGcd,[esi],[esi+4]
	mov  edx,OFFSET str1
	call WriteString
	call WriteDec
	call Crlf
	add  esi,TYPE array * 2
	loop L1

	exit
main ENDP

;---------------------------------------------
CalcGcd PROC,
	int1:DWORD, int2:DWORD
;
; Calculate the greatest common divisor, of two
; nonnegative integers, using Euclid's algrithm.
; Implemented using recursion.
; Receives: int1, int2
; Returns:  EAX = Greatest common divisor
;---------------------------------------------
	mov  eax,int1
	mov  ebx,int2
	mov  edx,0		; clear high dividend
	div ebx		; divide int1 by int2
	cmp  edx,0		; remainder = 0?
	je   L2		; yes: quit
	INVOKE CalcGcd,ebx,edx		; recursive call

L2:	mov eax,ebx		; EAX = GCD
	ret
CalcGcd ENDP

END main