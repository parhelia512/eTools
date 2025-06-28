object frmSysSearch: TfrmSysSearch
  Left = 0
  Top = 0
  Caption = #31995#32479#25628#32034#36335#24452' v2.0'
  ClientHeight = 696
  ClientWidth = 1156
  Color = clBlack
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    1156
    696)
  TextHeight = 13
  object lst1: TListBox
    Left = 8
    Top = 8
    Width = 1022
    Height = 680
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = 3947580
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 0
    OnDblClick = btnSysSearchModifyClick
  end
  object pnlOP: TPanel
    Left = 1036
    Top = 8
    Width = 112
    Height = 680
    Anchors = [akTop, akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'pnlOP'
    Color = 2829099
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      112
      680)
    object btnSysSearchAdd: TButton
      Left = 15
      Top = 8
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #28155#21152
      TabOrder = 0
      OnClick = btnSysSearchAddClick
    end
    object btnSysSearchModify: TButton
      Left = 15
      Top = 130
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #20462#25913
      TabOrder = 1
      OnClick = btnSysSearchModifyClick
    end
    object btnSysSearchUp: TButton
      Left = 15
      Top = 171
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #19978#31227
      TabOrder = 2
      OnClick = btnSysSearchUpClick
    end
    object btnSysSearchDown: TButton
      Left = 15
      Top = 211
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #19979#31227
      TabOrder = 3
      OnClick = btnSysSearchDownClick
    end
    object btnSysSearchUpTop: TButton
      Left = 15
      Top = 252
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #19978#31227#21040#39030#31471
      TabOrder = 4
      OnClick = btnSysSearchUpTopClick
    end
    object btnSysSearchDownBottom: TButton
      Left = 15
      Top = 293
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #19979#31227#21040#24213#31471
      TabOrder = 5
      OnClick = btnSysSearchDownBottomClick
    end
    object btnSysSearchBackup: TButton
      Left = 15
      Top = 334
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #22791#20221
      TabOrder = 6
      OnClick = btnSysSearchBackupClick
    end
    object btnSysSearchRestore: TButton
      Left = 15
      Top = 375
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #36824#21407
      TabOrder = 7
      OnClick = btnSysSearchRestoreClick
    end
    object btnSysSearchDel: TButton
      Left = 15
      Top = 89
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #21024#38500
      TabOrder = 8
      OnClick = btnSysSearchDelClick
    end
    object btnInputSysSearch: TButton
      Left = 15
      Top = 48
      Width = 85
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #36755#20837
      TabOrder = 9
      OnClick = btnInputSysSearchClick
    end
  end
end
