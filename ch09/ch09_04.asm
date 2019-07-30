;TITLE Chapter 9 Exercise 4              (ch09_04.asm)



Comment !
Description: Write a procedure named Str_find that searches for the
first matching occurrence of a source string inside a target string
and returns the matching position. The input parameters should be a
pointer to the source string and a pointer to the target string. If
a match is found, the procedure sets the Zero flag and EAX points to
the matching position in the target string. Otherwise, the Zero
flag is clear.

Difficulty level: 5/5



INCLUDE Irvine32.inc

Str_find PROTO, pTarget:PTR BYTE, pSource:PTR BYTE

.data
target BYTE "01ABAAAAAABABCC45ABC9012",0
source BYTE "AAABA",0

str1 BYTE "Source string found at position ",0
str2 BYTE " in Target string (counting from zero).",0Ah,0Ah,0Dh,0
str3 BYTE "Unable to find Source string in Target string.",0Ah,0Ah,0Dh,0

stop      DWORD ?
lenTarget DWORD ?
lenSource DWORD ?
position  DWORD ?

.code
main PROC

	INVOKE Str_find,ADDR target, ADDR source
	mov  position,eax
	je   wasfound       ;zero flag returned set = found

	mov  edx,OFFSET str3	; string not found
	call WriteString
	jmp quit

wasfound:	; display message
	mov  edx,OFFSET str1
	call WriteString
	mov  eax,position	; write position value
	call WriteDec
	mov  edx,OFFSET str2
	call WriteString

quit:
	exit

main ENDP

;--------------------------------------------------------
Str_find PROC, pTarget:PTR BYTE, ;PTR to Target string
               pSource:PTR BYTE  ;PTR to Source string
;
; Searches for the first matching occurrence of a source
; string inside a target string.
; Receives: pointer to the source string and a pointer
; 	to the target string.
; Returns: If a match is found, ZF=1 and EAX points to
; the offset of the match in the target string.
; IF ZF=0, no match was found.
;--------------------------------------------------------
	INVOKE Str_length,pTarget	; get length of target
	mov  lenTarget,eax
	INVOKE Str_length,pSource	; get length of source
	mov  lenSource,eax

	mov  edi,OFFSET target	; point to target
	mov  esi,OFFSET source	; point to source

; Compute place in target to stop search
	mov  eax,edi           	; stop = (offset target)
	add  eax,lenTarget     	;       + (length of target)
	sub  eax,lenSource     	;       - (length of source)
	inc  eax               	;       + 1
	mov  stop,eax	; save the stopping position


; Compare source string to current target
	cld
	mov  ecx,lenSource     	; length of source string
L1:
	pushad
	repe cmpsb	; compare all bytes
	popad
	je   found	; if found, exit now

	inc  edi	; move to next target position
	cmp  edi,stop	; has EDI reached stop position?
	jae  notfound	; yes: exit
	jmp  L1	; not: continue loop

notfound:	; string not found
	or   eax,1	; ZF=0 indicates failure
	jmp  done

found:	; string found
	mov  eax,edi	; compute position in target of find
	sub  eax,pTarget
	cmp  eax,eax           	; ZF=1 indicates success

done:
	ret
Str_find ENDP

END main