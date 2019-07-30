TITLE  Binary Search Procedure                  (Bsearch.asm)

Comment !
Description: Binary Search procedure. The programming exercise is to
rewrite the binary search procedure shown in this chapter by using
registers for mid, first, and last. Add comments to clarify the
registers' usage. Modified version for Chapter 9, Exercise 9.
!
INCLUDE Irvine32.inc

.code
;-------------------------------------------------------------
BinarySearch PROC uses ebx edx esi edi,
	pArray:PTR DWORD,		; pointer to array
	Count:DWORD,		; array size
	searchVal:DWORD		; search value
;
; Search an array of signed integers for single value.
; Receives: Pointer to array, array size, search value.
; Returns: If a match is found, EAX = the array position of the
; matching element; otherwise, EAX = -1.
;-------------------------------------------------------------

	mov ebx,0		; first (EBX) = 0
	mov ecx,Count		; last (ECX) = count - 1
	dec ecx

; Caution: if you use .WHILE ebx <= ecx, the assembler generates
; an unsigned jump instruction. This causes the algorithm to fail
; when the search value is smaller than the first item in the array.

L1:	cmp ebx,ecx		; while( first <= last )
	jnle L2

	; mid (EDX) = (last + first) / 2
	mov edx,ecx
	add edx,ebx
	shr edx,1		; EDX = mid

	mov esi,pArray		; EAX = values[mid]
	mov eax,[esi+edx*4]

	.IF eax < searchVal
	  mov ebx,edx		; first = mid + 1
	  inc ebx
	.ELSEIF eax > searchVal
	  mov ecx,edx		; last = mid - 1
	  dec ecx
	.ELSE
	  mov eax,edx		; return mid
	  jmp Exit_proc
	.ENDIF

	jmp L1		; continue the loop


L2:	mov  eax,-1		; search failed

Exit_proc:
	ret
BinarySearch ENDP

END