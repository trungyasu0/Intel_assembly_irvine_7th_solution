include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 

.data
message BYTE ":  This line of text was written "
        BYTE "to the screen buffer",0dh,0ah
messageSize = ($ - message)

outHandle DWORD 0	; standard output handle
bytesWritten  DWORD ?	; number of bytes written
lineNum DWORD 0
windowRect SMALL_RECT <0,0,79,24>	; left,top,right,bottom

.code
main PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov outHandle, eax

;Write 50 lines of text to the screen buffer

.REPEAT
  	mov eax, lineNum
  	call WriteDec	; display each line number
	INVOKE WriteConsole,
	  outHandle,	; console output handle
	  ADDR message,	; string pointer
	  messageSize,	; string length
	  ADDR bytesWritten,	; returns num bytes written
	  0	; not used
  	inc  lineNum	; next line number
.UNTIL lineNum > 50

;Reposition the console window relative to the screen buffer

	mov ecx, 52	; lines to scroll
L1:	push ecx	; save counter
	INVOKE SetConsoleWindowInfo,
	  outHandle,
	  TRUE,
	  ADDR windowRect

	mov eax, 500	; delay (0.5 seconds)
	call Delay	; wait

	inc windowRect.Top	; next line
	inc windowRect.Bottom
	pop ecx	; restore counter
	loop L1

	INVOKE ExitProcess,0
main ENDP
END main