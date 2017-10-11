@echo off

set RELEASEDIR=d:\Users\jbb\release
set ZIP="c:\Program Files\7-zip\7z.exe"


set VERSIONFILE=RetractableLiftingSurface.version
rem The following requires the JQ program, available here: https://stedolan.github.io/jq/download/
c:\local\jq-win64  ".VERSION.MAJOR" %VERSIONFILE% >tmpfile
set /P major=<tmpfile

c:\local\jq-win64  ".VERSION.MINOR"  %VERSIONFILE% >tmpfile
set /P minor=<tmpfile

c:\local\jq-win64  ".VERSION.PATCH"  %VERSIONFILE% >tmpfile
set /P patch=<tmpfile

c:\local\jq-win64  ".VERSION.BUILD"  %VERSIONFILE% >tmpfile
set /P build=<tmpfile
del tmpfile
set VERSION=%major%.%minor%.%patch%
if "%build%" NEQ "0"  set VERSION=%VERSION%.%build%

echo Version:  %VERSION%


copy bin\Release\RetractableLiftingSurface.dll ..\GameData\RetractableLiftingSurface\Plugins
copy  RetractableLiftingSurface.version ..\GameData\RetractableLiftingSurface\RetractableLiftingSurface.version

copy /y ..\LICENSE ..\Gamedata\RetractableLiftingSurface

cd ..
set FILE="%RELEASEDIR%\RetractableLiftingSurface-%VERSION%.zip"
IF EXIST %FILE% del /F %FILE%
%ZIP% a -tzip %FILE% GameData\RetractableLiftingSurface 
