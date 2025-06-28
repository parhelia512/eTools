#include <windows.h>

HINSTANCE hinst = NULL;

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
    switch (ul_reason_for_call)
    {
      case DLL_PROCESS_ATTACH:
        hinst = (HINSTANCE)hModule;
      case DLL_THREAD_ATTACH:
      case DLL_THREAD_DETACH:
      case DLL_PROCESS_DETACH:
          break;
    }
    return TRUE;
}

enum TLangStyle {lsDelphiDll, lsVCDLGDll, lsVCMFCDll, lsQTDll, lsEXE};

extern int WINAPI WinMain(HINSTANCE hInstance,HINSTANCE hPrevInst,LPSTR lpCmdLine,int nCmdShow);

extern "C" __declspec(dllexport) void db_ShowDllForm_Plugins(TLangStyle* lsFileType, char** strModuleName, char** strClassName, char** strWindowName, const bool show = false)
{
    * lsFileType       = lsQTDll;                 // TLangStyle
    * strModuleName    = "开发工具/CMake-GUI";    // 模块名称
    * strClassName     = "Qt5152QWindowIcon";     // 主窗体类名
    * strWindowName    = "CMakeSetup";            // 主窗体标题文本
    
    if (show) 
    {
      WinMain(hinst, 0, (LPSTR)"", (int)show);
    }
}

