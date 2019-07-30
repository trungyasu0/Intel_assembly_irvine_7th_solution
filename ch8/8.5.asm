include \Irvine\Irvine32.inc 
includelib \Irvine\Irvine32.lib
includelib \Irvine\Kernel32.lib
includelib \Irvine\User32.lib 

DifferentInputs PROTO,
	input1:DWORD,
	input2:DWORD,
	input3:DWORD

.CODE
main PROC
	call	Clrscr
	INVOKE DifferentInputs, 1, 1, 1
	call	DumpRegs	; EAX = 0
	INVOKE DifferentInputs, 2, 1, 1
	call	DumpRegs	; EAX = 0
	INVOKE DifferentInputs, 1, 2, 3
	call	DumpRegs	; EAX = 1
	INVOKE DifferentInputs, 1, 2, 1
	call	DumpRegs	; EAX = 0
	INVOKE DifferentInputs, 0, 1, 4
	call	DumpRegs	; EAX = 1
	exit
main ENDP

DifferentInputs PROC USES ebx edx,
	input1:DWORD,
	input2:DWORD,
	input3:DWORD
;
; Returns 1 if the values of the three input parameters are all different;
; otherwise returns 0.
; Returns: EAX
;-----------------------------------------------------
	mov	ebx,input1
	mov	edx,input2
	cmp	ebx,edx
	je	Equal
	cmp	ebx,input3
	je	Equal
	cmp	edx,input3
	je	Equal
	mov	eax,1
	jmp	Done
Equal:
	mov	eax,0
Done:
	ret
DifferentInputs ENDP

END main