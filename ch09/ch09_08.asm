include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib

 
.data?
exchangeFlag dword ?
;BubbleSort 
.code 
BubbleSort proc uses eax ecx esi ebx,
	pArray: ptr dword,			;point to the array 
	count :dword				;array size 
	mov 	exchangeFlag, 0		;set up default value for exchangeFlag
	mov 	ecx, count 
	dec 	ecx 				; ecx = size array -1 
	
L1: push	ecx 
	mov 	esi, pArray 

L2:	mov		eax, [esi] 			; array element 
	cmp 	eax, [esi + 4]		; compare arr[n] with arr[n+1]
	jl 		L3 					      ; arr[n] < arr[n+1] ?
	xchg	eax, [esi + 4]		; if not exchange 
	mov		[esi], eax 
	mov 	exchangeFlag, 1		;if have exchange -> exchangeFlag = 1
L3:	add		esi, 4				  ; if yes
	loop	L2 
	pop		ecx 
	loop 	L1 

	ret 
	BubbleSort endp
end
