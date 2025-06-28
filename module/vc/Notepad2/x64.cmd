@echo off
setlocal enabledelayedexpansion
color A

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

:: 修改源码
CD /D %CurrentCD%SRC
git apply -v %CurrentCD%np2.patch 

:: 编译原有的 NOTEPAD2 源码
call %CurrentCD%SRC\Build\build_vs2017.bat /Build /x64 /Release

:: 编译 np2.CPP
CD /D %CurrentCD%
cl /c  /Zi /nologo /W3 /WX- /diagnostics:classic /O2 /Oy- /GL /D WIN32 /D STATIC_BUILD /D BOOKMARK_EDITION /D NDEBUG /D _CRT_SECURE_NO_WARNINGS /D _UNICODE /D UNICODE /Gm- /EHsc /MT /GS /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /Gd /analyze- /FC  %CurrentCD%np2.cpp

:: 与原来编译 EXE 产生出的 OBJ/LIB/RES 一起，连接为动态库
link /dll -out:np2.dll -nologo -RELEASE -OPT:REF -OPT:ICF -LTCG /LARGEADDRESSAWARE /FIXED:NO np2.obj %CurrentCD%SRC\bin\VS2017\Release_x64\obj\*.obj %CurrentCD%notepad2.res %CurrentCD%SRC\bin\VS2017\Release_x64\obj\scintilla\Scintilla.lib imm32.lib Shlwapi.lib Comctl32.lib Msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib OpenGL32.Lib

:: 复制到 plugins 目录下
copy /Y np2.dll ..\..\..\bin\Win64\Release\plugins\np2.dll

:: 还原源码
CD /D %CurrentCD%SRC
git clean -d  -fx -f 
git checkout .

:: 删除临时文件
CD /D %CurrentCD%
del np2.dll
del np2.exp
del np2.lib
del np2.obj
del vc140.pdb
