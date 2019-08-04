title Last Access Date of a File

include \Irvine\Irvine32.inc
includelib \Irvine\Irvine32.lib
includelib \masm32\lib\User32.lib
includelib \masm32\lib\Kernel32.lib

.data
	filename	db	"D:\Python\Test\new3.py", 0
	len_name	dd	($ - filename)
	
	promt		db	"was last accessed on:", 0
	len_pr		dd	($ - promt)

	fault 		db 	"Something went wrong, bye bye", 0
	len_fault	dd	($ - fault)

	char 		db 	"/"
	
	year		dw	?
	month		dw	?
	day			dw	?
	string		db	15 dup (0)
	len			dd	?
	OutHAndle	dd	?
	FileHandle	dd	?
	time		SYSTEMTIME	<>
	ByteToWrite	dd	?
.code
atoi proc, number : word
	movzx eax, number
	mov ebx, 10
	mov [len], 0
	mov esi, offset string
	add esi, 5

	LABEL_0:
		dec esi
		mov edx, 0
		idiv ebx
		add edx, 30h
		mov byte ptr [esi], dl
		inc [len]
		cmp eax, 0
		jne LABEL_0
	ret
atoi endp	

_Fault:
	invoke WriteConsole, OutHAndle, offset fault, len_fault, ADDR ByteToWrite, 0
	invoke CloseHandle, FileHandle
	invoke ExitProcess, 0

main:	
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	mov OutHAndle, eax
	
	invoke CreateFile, offset filename, GENERIC_READ, DO_NOT_SHARE, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0							
	mov FileHandle, eax
	cmp eax, 0
	jle _Fault
	invoke CloseHandle, FileHandle
	invoke GetLocalTime, offset time
	
	mov ax, time.wYear
	mov word ptr [year], ax
	mov ax, time.wMonth
	mov word ptr [month], ax
	mov ax, time.wDay
	mov word ptr [day], ax
	
	invoke WriteConsole, OutHAndle, offset filename, len_name, offset ByteToWrite, 0
	invoke WriteConsole, OutHAndle, offset promt, len_pr, offset ByteToWrite, 0
	
	invoke atoi, day
	invoke WriteConsole, OutHAndle, esi, len, ADDR ByteToWrite, 0
	invoke WriteConsole, OutHAndle, ADDR char, 1, ADDR ByteToWrite, 0

	invoke atoi, month
	invoke WriteConsole, OutHAndle, esi, len, ADDR ByteToWrite, 0
	invoke WriteConsole, OutHAndle, ADDR char, 1, ADDR ByteToWrite, 0

	invoke atoi, year
	invoke WriteConsole, OutHAndle, esi, len, ADDR ByteToWrite, 0

	invoke ExitProcess, 0
end main	
