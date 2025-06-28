object frmEdge: TfrmEdge
  Left = 0
  Top = 0
  Caption = 'frmEdge'
  ClientHeight = 639
  ClientWidth = 970
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object EdgeBrowser: TEdgeBrowser
    Left = 0
    Top = 0
    Width = 970
    Height = 639
    Align = alClient
    TabOrder = 0
    AllowSingleSignOnUsingOSPrimaryAccount = False
    TargetCompatibleBrowserVersion = '117.0.2045.28'
    UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
    OnCreateWebViewCompleted = EdgeBrowserCreateWebViewCompleted
    OnNavigationCompleted = EdgeBrowserNavigationCompleted
  end
  object tmrStart: TTimer
    Interval = 100
    OnTimer = tmrStartTimer
    Left = 88
    Top = 104
  end
end
