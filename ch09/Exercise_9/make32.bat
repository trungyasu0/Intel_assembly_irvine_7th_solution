REM  make32.bat -  Batch file for assembling/linking Exercise 9

@echo off
cls

REM The following three lines can be customized for your system:
REM ********************************************BEGIN customize
PATH c:\masm615
SET INCLUDE=c:\masm615\include
SET LIB=c:\masm615\lib
REM ********************************************END customize

ML -Zi -c -Fl -coff ch09_09.asm Bsort.asm FillArry.asm PrtArry.asm BSearch.asm
if errorlevel 1 goto terminate

REM add the /MAP option for a map file in the link command.

LINK32 ch09_09.obj Bsearch.obj Bsort.obj FillArry.obj PrtArry.obj irvine32.lib kernel32.lib /SUBSYSTEM:CONSOLE /DEBUG
if errorLevel 1 goto terminate

dir ch09_09.*

:terminate
pause