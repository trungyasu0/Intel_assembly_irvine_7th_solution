include \Irvine\Irvine32.inc 
includelib \Irvine\Irvine32.lib
includelib \Irvine\Kernel32.lib
includelib \Irvine\User32.lib 

.data 
packer_1  word 4536h
packer_2    word 7207h

sum dword ?

.code
main proc 
    mov     sum, 0
main endp

AddPacker proc 
;ESI - pointer to the first number
;EDI - pointer to the second number
;EDX - pointer to the sum
;ECX - number of bytes to add
    pushad  

    mov     ebx, 0      ;initialize index = 0 
loop_add:
    ;add low byte
    mov     al, byte ptr packer_1[ebx]
    add     al, byte ptr packer_2[ebx]
    daa 
    mov     byte ptr [edx + ebx], al 
    
    ;add high byte
    inc     ebx 
    mov     al, byte ptr packer_1[ebx]
    adc     al, byte ptr packer_2[ebx]
    daa 
    mov     byte ptr [edx + ebx], al 

    ;add final carry flag if any 
    inc     ebx 
    mov     al, 0
    adc     al, 0
    mov     byte ptr [edx + ebx], al 

    loop    loop_add 
    popad
AddPacker endp

end main


