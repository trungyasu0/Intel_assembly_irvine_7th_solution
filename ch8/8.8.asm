include \Irvine\Irvine32.inc 
includelib \Irvine\Irvine32.lib
includelib \Irvine\Kernel32.lib
includelib \Irvine\User32.lib 

N = 16

CountMatches PROTO,
    pArray1: ptr SDWORD,
    pArray2: ptr SDWORD,
    lengthArray: DWORD 

.DATA
array1	SDWORD	1,-2,4,5,-6,3,3,4,7,-8,9,-3,3,3,-5,6
array2	SDWORD	3,3,-2,5,6,3,3,-7,7,-8,3,3,-9,0,0,-3

.CODE
main proc 
    INVOKE  CountMatches, ADDR array1, ADDR array2, N 
    call    WriteDec 
    exit
main endp 
;--------------------------------------------------------------
;this procedure will return number of matching array in eax
CountMatches PROC uses esi edi ebx ecx,
    pArray1: ptr SDWORD,
    pArray2: ptr SDWORD,
    lengthArray: DWORD
;--------------------------------------------------------------
    mov     esi, pArray1        ; esi point to array_1 
    mov     edi, pArray2        ; edi point to array_2 
    mov     ecx, lengthArray    ; ecx = length of two array 
    mov     eax, 0              ; initialize eax = 0
loop_count:
    mov     ebx , [esi]
    cmp     ebx, [edi]
    jnz     nextElement 
    inc     eax                 ; if esi[i] = edi[i] -> eax ++ 

nextElement:
    add     esi, 4 
    add     edi, 4   
    loop    loop_count    

    ret
CountMatches endp 


end main 