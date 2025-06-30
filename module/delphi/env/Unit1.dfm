object frmEnv: TfrmEnv
  Left = 0
  Top = 0
  Caption = #31995#32479#29615#22659#21464#37327
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clWhite
    Ctl3D = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WantReturns = False
    WantTabs = True
  end
  object tmrStart: TTimer
    Interval = 100
    OnTimer = tmrStartTimer
    Left = 56
    Top = 120
  end
end
