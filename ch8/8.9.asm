include \Irvine\Irvine32.inc 
includelib \Irvine\Irvine32.lib
includelib \Irvine\Kernel32.lib
includelib \Irvine\User32.lib 

N = 16
DIF = 3

CountNearMatches PROTO,
    pArray1: ptr SDWORD,
    pArray2: ptr SDWORD,
    lengthArray: DWORD,
    diff: DWORD  

.data 
array1	SDWORD	1,-2,4,5,-6,3,3,4,7,-8,9,-3,3,3,-5,6
array2	SDWORD	3,3,-2,5,6,3,3,-7,7,-8,3,3,-9,0,0,-3

.code 
main proc 
    INVOKE  CountNearMatches, ADDR array1, ADDR array2, N , DIF
    call    WriteDec 
    exit
main endp 

;--------------------------------------------------------------
;this procedure will return number of near_matching array in eax
CountNearMatches PROC uses esi edi ebx ecx edx ,
    pArray1: ptr SDWORD,
    pArray2: ptr SDWORD,
    lengthArray: DWORD,
    diff: DWORD  
;--------------------------------------------------------------
    mov     esi, pArray1        ; esi point to array_1 
    mov     edi, pArray2        ; edi point to array_2 
    mov     ecx, lengthArray    ; ecx = length of two array 
    mov     edx, diff           ; 
    mov     eax, 0              ; initialize eax = 0
loop_count:

    ;compare distance of each element of two array with diff if < diff -> eax ++
    mov     ebx , [esi]
    cmp     ebx, [edi]
    jl      L1                  
    sub     ebx, edi
    cmp     ebx, edx 
    jl      L2 
    jmp     nextElement
    
L1: mov     ebx, [edi]
    sub     ebx, [esi] 
    cmp     ebx, edx  
    jl      L2 
    jmp     nextElement

L2: inc     eax     
nextElement:
    add     esi, 4 
    add     edi, 4   
    loop    loop_count    

    ret
CountNearMatches endp 
end main 