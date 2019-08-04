include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 

Read_String PROTO,
	bufferPtr:PTR DWORD,
	bufferSize:DWORD,

BufSize = 80

.data
buffer BYTE BufSize DUP(?)
msg BYTE "Please enter a string: "

.code
main PROC

; Display a prompt
	mov edx, OFFSET msg	; message to display
	call WriteString

; Input a string
	INVOKE Read_String,
	  ADDR buffer,	; points to buffer
	  BufSize	; size of buffer

; EAX now contains the number of bytes entered
	call DumpRegs

; Display the buffer
	mov edx,OFFSET buffer
	call WriteString
	call Crlf

;	mov esi, OFFSET buffer
;	mov ecx, eax	; number of characters read
;	mov ebx, TYPE buffer 	; one character per byte
;	call DumpMem

	exit
main ENDP

;-------------------------------------------------------
Read_String PROC USES esi,
	bufferPtr:PTR DWORD,
	bufferSize:DWORD
LOCAL stdInHandle:DWORD, bytesRead:DWORD
;
; Wrapper procedure for the function ReadConsole in the
; Windows API. The user enters a string which is stored
; in the buffer pointed to by the bufferPtr parameter.
; Receives: bufferPtr and bufferSize
; Returns: EAX = number of characters actually entered
;-------------------------------------------------------
;.data
;stdInHandle DWORD ?
;bytesRead DWORD ?
;.code
	; Get handle to standard input
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov stdInHandle, eax	; save standard input handle

	; Get user input
	INVOKE ReadConsole, stdInHandle, bufferPtr,
	   bufferSize, ADDR bytesRead, 0

	sub bytesRead,2
	mov esi, bufferPtr	; ESI = pointer to buffer
	add esi, bytesRead	; ESI = end of buffer
;	sub esi, 2	; ESI = position of 0Dh
;	mov al, 0	; AL = null
	mov BYTE PTR[esi], 0	; replace 0Dh with null

	mov eax, bytesRead	; EAX = characters read

	ret
Read_String ENDP

END main