@echo off
if [%1]==[/help] goto usage
if [%1]==[] goto missing

SET TMPFILE=c:\to_be_deleted\trash%RANDOM%
mkdir %TMPFILE%
@echo Moving %1 to %TMPFILE%
move %1 %TMPFILE%
@echo Done.
goto :eof
:missing
@echo Missing directory or file name
:usage
@echo Usage: delq ^<directory/file name^>
exit /B 1