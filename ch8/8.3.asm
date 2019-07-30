include \Irvine\Irvine32.inc 
includelib \Irvine\Irvine32.lib
includelib \Irvine\Kernel32.lib
includelib \Irvine\User32.lib 

DrawRow proto, 
    rowNum:byte 

DrawSquare proto,
    bgColour:byte 

DrawBoard proto

.code 
main proc 
    call    Clrscr 
    INVOKE  DrawBoard
    
    exit 
main endp
;----------------------------------------------------------------------------
DrawRow proc uses eax ecx edx edi,
    rowNum:byte
; Draws a row of the chess board.
; Returns: nothing.
L1:
    mov     dh, rowNum      ;current row 
    mov     ecx, 8 
    mov     dl, 0           ; first X-coordinate
DrawSquares:
    call    Gotoxy          ; locate cursor at 
    mov		al,dl
	add		al,dh
	test	al,1			; parity check
	jnp		DrawWhite		; if odd, draw white
	INVOKE	DrawSquare, gray 
	jmp		next			; if even, draw gray
DrawWhite:
	INVOKE	DrawSquare, white 
next:
	inc		dl
	loop	DrawSquares
   
	ret
DrawRow ENDP

;----------------------------------------------------------------------------
DrawSquare PROC USES eax ecx ,
	bgColour:BYTE			; square colour
;
; Draws a square.
; Returns: nothing.
    movzx	eax,bgColour	; 8 denotes gray square, 15 denotes white square
	shl		eax, 4 		    ; multiply background colour by 16
	call	SetTextColor
	mov		al,'_'		    ; draw blank character
	call	WriteChar
	ret
DrawSquare ENDP
;----------------------------------------------------------------------------
DrawBoard PROC USES eax ecx
;
; Draws the entire chess board.
; Returns: nothing.
	mov	ecx,8
DrawChessBoard:
	dec	cl
	INVOKE DrawRow, cl
	inc	cl
	loop	DrawChessBoard
	mov	    eax,0		; set foreground & background colours to black to hide waitmsg
	;call	SetTextColor
	ret
DrawBoard ENDP

end main 


