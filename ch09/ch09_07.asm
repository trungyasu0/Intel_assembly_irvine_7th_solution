

INCLUDE Irvine32.inc

PrintPrimes PROTO,
	count:DWORD	; number of values to display

FIRST_PRIME = 2
LAST_PRIME = 65000

.data
commaStr BYTE ", ",0
sieve WORD LAST_PRIME DUP(0)

.code
main PROC

	mov esi,FIRST_PRIME

	.WHILE esi < LAST_PRIME
	  .IF sieve[esi*TYPE sieve] == 0		; is current entry prime?
	    call MarkMultiples		; yes: mark all of its multiples
	  .ENDIF
	  inc esi		; move to next table entry
	.ENDW

	INVOKE PrintPrimes, 8000		; display range 1..8000

	exit
main ENDP

;--------------------------------------------------
MarkMultiples PROC
;
; Mark all multiples of the value passed in ESI.
; Notice we use ESI as the prime value, and
; take advantage of the "scaling" feature of indirect
; operands to locate the address of the indexed item:
; [esi*TYPE sieve]
;--------------------------------------------------
	push eax
	push esi
	mov  eax,esi		; prime value
	add  esi,eax		; start with first multiple

L1:	cmp esi,LAST_PRIME		; end of array?
	ja  L2		; yes
	mov sieve[esi*TYPE sieve],1	; no: insert a marker
	add esi,eax
	jmp L1		; repeat the loop

L2:	pop esi
	pop eax
	ret
MarkMultiples ENDP


;--------------------------------------------------
PrintPrimes PROC,
	count:DWORD	; number of values to display
;
; Display the list of prime numbers
;--------------------------------------------------
	mov esi,1
	mov eax,0
	mov ecx,count

L1:	mov ax,sieve[esi*TYPE sieve]
	.IF ax == 0
	  mov  eax,esi
	  call WriteDec
	  mov edx,OFFSET commaStr
	  call WriteString
	.ENDIF
	inc esi
	loop L1

	ret
PrintPrimes ENDP

END main