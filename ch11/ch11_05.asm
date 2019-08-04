include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 

BoxWidth = 20
BoxHeight = 14

.data
boxTop    BYTE 0DAh, (BoxWidth - 2) DUP(0C4h), 0BFh
boxBody   BYTE 0B3h, (BoxWidth - 2) DUP(' '), 0B3h
boxBottom BYTE 0C0h, (BoxWidth - 2) DUP(0C4h), 0D9h

outputHandle DWORD 0
bytesWritten DWORD 0
count DWORD 0
xyPosition COORD <10,5>

.code
main PROC

	; Get the console ouput handle
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov outputHandle, eax	; save console handle

	; draw top of the box
	INVOKE WriteConsoleOutputCharacter,
	   outputHandle,	; console output handle
	   ADDR boxTop,	; pointer to the top box line
	   BoxWidth,	; size of box line
	   xyPosition,	; coordinates of first char
	   ADDR count	; output count

	inc xyPosition.Y	; next line

	mov ecx, (BoxHeight - 2)	; number of lines in body
L1:	push ecx	; save counter
	INVOKE WriteConsoleOutputCharacter,
	   outputHandle,	; console output handle
	   ADDR boxBody,	; pointer to the box body
	   BoxWidth,	; size of box line
	   xyPosition,	; coordinates of first char
	   ADDR count	; output count

	inc xyPosition.Y	; next line
	pop ecx	; restore counter
	loop L1

	; draw bottom of the box
	INVOKE WriteConsoleOutputCharacter,
	   outputHandle,	; console output handle
	   ADDR boxBottom,	; pointer to the bottom of the box
	   BoxWidth,	; size of box line
	   xyPosition,	; coordinates of first char
	   ADDR count	; output count

	exit
main ENDP
END main