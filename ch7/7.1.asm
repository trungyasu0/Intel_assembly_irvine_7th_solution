include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 

DECIMAL_OFFSET = 5

.data
decimal_one 	byte	"100123456789765"
decimal_two 	byte	"64546565455"
decimal_three	byte	"789765"

.code
main proc
	mov	ebx,DECIMAL_OFFSET
	call	Clrscr
	;test_1
	mov	edx,OFFSET decimal_one
	mov	ecx,LENGTHOF decimal_one
	call	WriteScaled

	;test_2
	call	Crlf
	mov	edx,OFFSET decimal_two
	mov	ecx,LENGTHOF decimal_two
	call	WriteScaled

	;test_3
	call	Crlf
	mov	edx,OFFSET decimal_three
	mov	ecx,LENGTHOF decimal_three
	call	WriteScaled

	call	Crlf

	exit
main endp


;this proc  will print dec_scaled
;edx = offset of number 
;ecx - length of number 
;ebx - decimal offset
WriteScaled proc 
	pushad			; save register
	sub	ecx, ebx	; length befor "."
print_char_before:
	mov	al, [edx]
	call	WriteChar 
	inc	edx
	loop	print_char_before

	;print "."
	mov	 al, '.'
	call	WriteChar
	
	;print char after "."
	mov	ecx, ebx
print_after:
	mov	al, [edx]
	call	WriteChar 
	inc	edx
	loop	print_after
	
	popad			;retrive register
	ret
WriteScaled endp

end main
