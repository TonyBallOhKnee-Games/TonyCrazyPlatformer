@echo off
color 0a
cd F:\TonyPlatformerHAXE\TonyCrazyPlatformer
echo BUILDING GAME
haxelib run lime build windows -release
echo.
echo done.
pause
pwd
explorer.exe export\release\windows\bin