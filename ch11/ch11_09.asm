include \Irvine32\Irvine32.inc 
includelib \Irvine32\Irvine32.lib
includelib \Irvine32\Kernel32.lib
includelib \Irvine32\User32.lib 
INCLUDE Macros.inc
INCLUDE GraphWin.inc

.data

filename byte "C:\Users\Quang Trung\Desktop\MASM\HomeWork\ch11\output.txt", 0

CreationTime1 SYSTEMTIME <>
LastAccessTime1 SYSTEMTIME <>
LastWriteTime1 SYSTEMTIME <>

.code
main PROC
;display file time
invoke FileDate, addr filename, addr CreationTime1, addr LastAccessTime1, addr LastWriteTime1

exit
main ENDP

;initialize proc 
FileDate proc,
NameOfFile: ptr byte,
TimeOfCreation: ptr SYSTEMTIME,
TimeOfLastAccess: ptr SYSTEMTIME,
TimeOfLastWrite: ptr SYSTEMTIME
local FileHandle: handle, CreationTime: FILETIME, LastAccessTime: FILETIME, LastWriteTime: FILETIME

;great file 
INVOKE CreateFile,
NameOfFile,
GENERIC_READ, 
DO_NOT_SHARE,
NULL,
OPEN_EXISTING, 
FILE_ATTRIBUTE_NORMAL,
0

mov FileHandle, eax

;get file time 
invoke GetFileTime, FileHandle, addr CreationTime, addr LastAccessTime, addr LastWriteTime

invoke FileTimeToSystemTime, addr CreationTime, TimeOfCreation
invoke FileTimeToSystemTime, addr LastAccessTime, TimeOfLastAccess
invoke FileTimeToSystemTime, addr LastWriteTime, TimeOfLastWrite

invoke CloseHandle, FileHandle
ret
FileDate endp

END main