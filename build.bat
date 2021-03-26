@ECHO OFF

for /f "usebackq tokens=*" %%i in (`call "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -version "[15.0,17.0)" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
  set VSInstallDir=%%i
)

set "VSCMD_START_DIR=%CD%"
call "%VSInstallDir%\Common7\Tools\VsDevCmd.bat" -no_logo -arch=x86 > NUL

bash build_ffmpeg_msvc.sh x64 || EXIT /B 1
MSBuild.exe LAVFilters.sln /nologo /m /t:Rebuild /property:Configuration=Release /property:Platform=x64
IF ERRORLEVEL 1 EXIT /B 1

PAUSE
