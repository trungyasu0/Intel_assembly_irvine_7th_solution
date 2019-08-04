title Linked List

include \Irvine\Irvine32.inc
includelib \Irvine\Irvine32.lib
includelib \masm32\lib\User32.lib
includelib \masm32\lib\Kernel32.lib
BufSize = 64
Node struct
	value  dword			?
	next   dword ptr		?
Node ends	
.data
	buffer			db		BufSize dup (0)

	StructArray		Node	20 dup (<0, 0>)
	OutHandle		dd		?
	InHandle		dd		?

	promt			db		"Enter a number:", 0
	len_pr			dd		($ - promt)

	promt2			db		"Display array:", 0
	len_pr2			dd		($ - promt2)

	ByteToRead		dd		?
	ByteToWrite		dd		?

	string 			db		10 dup(0)
	len 			dd 		?

	space			db		" "

.code
DwordToString:
	push esi
	push ebx
	mov eax, [esi]
	mov [len], 0
	mov esi, offset string
	add esi, 10
	mov ebx, 10
	Label_6:
		dec esi
		mov edx, 0
		cmp eax, 0
		je Label_7
		idiv ebx
		add edx, 30h
		inc [len]
		mov byte ptr [esi], dl
		jmp Label_6
Label_7:
	inc esi
	mov eax, esi
	pop ebx
	pop esi		
	ret
;------------------------------------------------------------------------------------------------------	
StringToDword:
	push esi
	push ebx
	push ecx
	mov eax, 0
	mov esi, offset buffer
	mov ecx, 10
	Label_3:
		cmp byte ptr [esi], 0Dh
		je Label_4
		imul ecx
		movzx ebx, byte ptr [esi]
		sub ebx, 30h
		add eax, ebx
		inc esi
		jmp Label_3
Label_4:
	pop ecx
	pop ebx
	pop esi			
	ret	
;--------------------------------------------------------------------------------------------------	
main:
	invoke GetStdHAndle, STD_INPUT_HANDLE
	mov InHandle, eax

	invoke GetStdHAndle, STD_OUTPUT_HANDLE
	mov OutHandle, eax
	mov esi, offset StructArray
	mov edi, esi
	Label_0:
		invoke WriteConsole, OutHandle, offset promt, len_pr, addr ByteToWrite, 0
		invoke ReadConsole, InHandle, offset buffer, BufSize, addr ByteToRead, 0
		cmp byte ptr [buffer], 30h
		je Label_1
		call StringToDword
		mov [esi], eax
		add esi, 4
		add edi, 8
		mov [esi], edi
		mov esi, edi
		jmp Label_0
Label_1:
	call StringToDword
	mov [esi], eax
	add esi, 4
	mov dword ptr [esi], 0
Show:
	invoke WriteConsole, OutHandle, offset promt2, len_pr2, addr ByteToWrite, 0
	mov esi, offset StructArray
	Label_2:
		call DwordToString		;esi contain address of Node, convert value of Node to String and point eax to this
		invoke WriteConsole, OutHandle, eax, len, addr ByteToWrite, 0
		invoke WriteConsole, OutHandle, offset space, 1, addr ByteToWrite, 0
		mov edi, esi
		add edi, 4				
		mov esi, [edi]			;next Node
		cmp esi, 0							
		jne Label_2
	invoke ExitProcess, 0
end main			
		
