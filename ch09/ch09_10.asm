include \Irvine\Irvine32.inc 
includelib \Irvine\Irvine32.lib
includelib \Irvine\Kernel32.lib
includelib \Irvine\User32.lib

.data
nomal_char 	byte "BCDFGHJKLMNPQRSTVWXYZ", 0
vowel_char 	byte "UEOAI", 0

.code 
main proc 
    mov     ecx, 3
test_loop:
    call    print_matrix_letter
    call    Crlf 
    loop    test_loop
	exit
main endp

print_matrix_letter proc uses ecx 
    mov     ecx, 4
Loop_print:
    call    Print_matrix_row
    call    Crlf 
    loop    Loop_print
    ret 
print_matrix_letter endp

;this proceduce will print 1 row of matrix 
Print_matrix_row proc uses eax ecx 
    mov 	ecx, 4                  ;counter of loop
WriteMatrix :
	mov		eax, 10			        
	call	RandomRange             ; pick one random number in 1 - 10 
	cmp		eax, 5                  ; if eax < 5 -> print vowel char else -> print nomal char 
	jl		L1
	
	call	Print_random_nomal_char
	mov 	eax, ' '
	call	WriteChar
	jmp     continue

L1: call	Print_random_vowel_char
	mov 	eax, ' '
	call	WriteChar
continue:
	loop	WriteMatrix
    ret
Print_matrix_row endp

Print_random_nomal_char proc uses eax ebx 
	mov 	eax, 21 
	call	RandomRange                     ;pick a random number -> position of char in nomal array char 
	mov		ebx, OFFSET nomal_char
	add 	eax, ebx  
	mov 	eax, [eax]
	call 	WriteChar                       ; print random nomal char 
	ret
Print_random_nomal_char endp

Print_random_vowel_char proc uses eax ebx 
	mov 	eax, 5 
	call	RandomRange                     ;pick a random number -> position of char in vowel array char 
	mov		ebx, OFFSET vowel_char
	add 	eax, ebx  
	mov 	eax, [eax]
	call 	WriteChar                        ; print random vowel char 
	ret
Print_random_vowel_char endp

end main 