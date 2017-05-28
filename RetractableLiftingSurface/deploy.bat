
set H=R:\KSP_1.3.0_dev
echo %H%

set d=%H%
if exist %d% goto one
mkdir %d%
:one
set d=%H%\Gamedata
if exist %d% goto two
mkdir %d%
:two


copy /y bin\Debug\RetractableLiftingSurface.dll ..\GameData\RetractableLiftingSurface\Plugins
copy  /y RetractableLiftingSurface.version ..\GameData\RetractableLiftingSurface\RetractableLiftingSurface.version

xcopy /Y /E ..\GameData\RetractableLiftingSurface %H%\GameData\RetractableLiftingSurface

