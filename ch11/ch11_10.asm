include \Irvine32\Irvine32.inc 
include \Irvine32\Macros.inc
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 

BUFFER_SIZE = 1024

.data
buffer BYTE BUFFER_SIZE DUP(?)
filename    BYTE 80 DUP(0)
fileHandle  HANDLE ?

.code
main PROC

; Let user input a filename.
	mWrite	 "Enter an input filename: "
	mov		edx,OFFSET filename
	mov		ecx,SIZEOF filename
	call	ReadString

; Open the file for input.
	mov		edx,OFFSET filename
	call	OpenInputFile
	mov		fileHandle,eax

; Check for errors.
	cmp		eax,INVALID_HANDLE_VALUE		; error opening file?
	jne		file_ok					; no: skip
	mWrite	 <"Cannot open file",0dh,0ah>
	jmp	quit						; and quit
file_ok:

; Read the file into a buffer.
	mov		edx,OFFSET buffer
	mov		ecx,BUFFER_SIZE
	call	ReadFromFile
	
	cmp		eax, BUFFER_SIZE 		; file small ?
	jb		Display_buffer			; yes

; Display the buffer.
Display_buffer:
	mWrite 	<"Buffer:",0dh,0ah,0dh,0ah>
	mov		edx,OFFSET buffer	; display the buffer
	call	WriteString
	call	Crlf

close_file:
	mov	eax,fileHandle
	call	CloseFile

quit:
	exit
main ENDP

END main