; FindThrees Program	(Threes_main.asm)
include \Irvine\Irvine32.inc 
includelib \Irvine\Irvine32.lib
includelib \Irvine\Kernel32.lib
includelib \Irvine\User32.lib 

FindThrees PROTO,
	arrayPtr:PTR DWORD,
	arraySize:DWORD

.DATA
array1	DWORD	1,2,4,5,6,3,3,4,7,8,9,3,3,3,5,6
array2	DWORD	3,3,2,5,6,3,3,7,7,8,3,3,9,0,0,3
array3	DWORD	1,2,3,3,4,4,4,5,5,6,6,5,5,6,5,3,3,3

.CODE
main PROC
	INVOKE FindThrees, ADDR array1, LENGTHOF array1
	call	DumpRegs
	INVOKE FindThrees, ADDR array2, LENGTHOF array2
	call	DumpRegs
	INVOKE FindThrees, ADDR array3, LENGTHOF array3
	call	DumpRegs
	exit
main ENDP

;-----------------------------------------------------
FindThrees PROC,
	arrayPtr:PTR DWORD,
	arraySize:DWORD
	LOCAL counter:DWORD
;
; Returns 1 if an array has three consecutive values of 3 somewhere in the
; array. Otherwise, return 0.
; Returns: EAX = result.
	mov	esi,arrayPtr
	mov	ecx,arraySize
	mov	counter,0
TraverseArray:
	mov	eax,[esi]
	cmp	eax,3
	jne	Not3
	inc	counter
	jmp	Is3
Not3:
	mov	counter,0
Is3:
	cmp	counter,3
	jne	Increment
	mov	eax,1
	jmp	done
Increment:
	add	esi,TYPE DWORD
	loop	TraverseArray
	mov	eax,0
done:
	ret
FindThrees ENDP
END main