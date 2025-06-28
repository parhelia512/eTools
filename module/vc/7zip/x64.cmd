@echo off
setlocal enabledelayedexpansion
Color A

set CurrentCD=%~dp0

:: VS2022 安装路径
for %%G in (Community,Professional,Enterprise) do (
  if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\%%G" (
    set "VSInstallPath=%ProgramFiles(x86)%\Microsoft Visual Studio\2022\%%G"
  )
  if exist "%ProgramFiles%\Microsoft Visual Studio\2022\%%G" (
    set "VSInstallPath=%ProgramFiles%\Microsoft Visual Studio\2022\%%G"
  )
)

if "%VSInstallPath%"=="" (
  echo "Visual Studio 2022 not found"
  pause
  goto bEnd
)

call "%VSInstallPath%\Common7\Tools\vsdevcmd.bat" -no_logo -arch=x64

:: 编译原有的 7zip 源码
CD /D %CurrentCD%CPP\7zip
set CL=/MP
set PLATFORM=x64
nmake

:: 编译 7zFM.CPP
CD /D %CurrentCD%
cl /c  /Zi /nologo /W3 /WX- /diagnostics:classic /O2 /Oy- /GL /D WIN32 /D STATIC_BUILD /D BOOKMARK_EDITION /D NDEBUG /D _CRT_SECURE_NO_WARNINGS /D _UNICODE /D UNICODE /Gm- /EHsc /MT /GS /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /Gd /analyze- /FC  %CurrentCD%7zFM.cpp

:: 与原来编译 EXE 产生出的 OBJ/LIB/RES 一起，连接为动态库
link /dll -out:7zFM.dll /DELAYLOAD:mpr.dll -nologo -RELEASE -OPT:REF -OPT:ICF -LTCG /LARGEADDRESSAWARE /FIXED:NO 7zFM.obj %CurrentCD%CPP\7zip\Bundles\FM\x64\*.obj %CurrentCD%CPP\7zip\Bundles\FM\x64\resource.res comctl32.lib htmlhelp.lib comdlg32.lib Mpr.lib Gdi32.lib delayimp.lib oleaut32.lib ole32.lib user32.lib advapi32.lib shell32.lib

:: 复制到 plugins 目录下
copy /Y 7zFM.dll ..\..\..\bin\Win64\Release\plugins\7-zip.dll

:: 还原源码
CD /D %CurrentCD%
git clean -d  -fx -f 
git checkout .

pause
