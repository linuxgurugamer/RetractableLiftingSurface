@echo off
set DEFHOMEDRIVE=d:
set DEFHOMEDIR=%DEFHOMEDRIVE%%HOMEPATH%
set HOMEDIR=
set HOMEDRIVE=%CD:~0,2%

set RELEASEDIR=d:\Users\jbb\release
set ZIP="c:\Program Files\7-zip\7z.exe"
echo Default homedir: %DEFHOMEDIR%

rem set /p HOMEDIR= "Enter Home directory, or <CR> for default: "

if "%HOMEDIR%" == "" (
set HOMEDIR=%DEFHOMEDIR%
)
echo %HOMEDIR%

SET _test=%HOMEDIR:~1,1%
if "%_test%" == ":" (
set HOMEDRIVE=%HOMEDIR:~0,2%
)

type RetractableLiftingSurface.version
set /p VERSION= "Enter version: "

set d=%HOMEDIR\install
if exist %d% goto one
mkdir %d%
:one
set d=%HOMEDIR%\install\Gamedata
if exist %d% goto two
mkdir %d%
:two

rmdir /s /q %HOMEDIR%\install\Gamedata\RetractableLiftingSurface

copy bin\Release\RetractableLiftingSurface.dll ..\GameData\RetractableLiftingSurface\Plugins
copy  RetractableLiftingSurface.version ..\GameData\RetractableLiftingSurface\RetractableLiftingSurface.version

xcopy /Y /E ..\GameData\RetractableLiftingSurface  %HOMEDIR%\install\Gamedata\RetractableLiftingSurface\
copy /y ..\LICENSE %HOMEDIR%\install\Gamedata\RetractableLiftingSurface

%HOMEDRIVE%
cd %HOMEDIR%\install

set FILE="%RELEASEDIR%\RetractableLiftingSurface-%VERSION%.zip"
IF EXIST %FILE% del /F %FILE%
%ZIP% a -tzip %FILE% GameData\RetractableLiftingSurface 
