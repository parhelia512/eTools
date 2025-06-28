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

extern int WINAPI WinMain(HINSTANCE hInstance,HINSTANCE hPrevInst,LPSTR lpCmdLine,int nCmdShow);

enum TLangStyle {lsDelphi, lsVCDLG, lsVCMFC, lsQT, lsEXE};

extern "C" __declspec(dllexport) void db_ShowDllForm_Plugins(TLangStyle* lsFileType, char** strModuleName, char** strClassName, char** strWindowName, const bool show = false)
{
    * lsFileType       = lsVCDLG;                  // TLangStyle
    * strModuleName    = "压缩解压缩/7-Zip(DLL)";  // 模块名称
    * strClassName     = "7-Zip::FM";              // 主窗体类名
    * strWindowName    = "7-Zip";                  // 主窗体标题文本

    if (show) 
    {
      WinMain(hinst, 0, (LPSTR)"", (int)show);
    }
}

