@echo off

set appname=chal16

if exist %appname%.obj del %appname%.obj
if exist %appname%.exe del %appname%.exe

\masm32\bin64\ml64.exe /c %appname%.asm

\masm32\bin64\polink.exe /SUBSYSTEM:WINDOWS /MACHINE:X64 /ENTRY:main /LARGEADDRESSAWARE %appname%.obj

dir %appname%.*

pause
