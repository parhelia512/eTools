object frmChina: TfrmChina
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #20013#22269#30340#34892#25919#21306#21010'('#20116#32423')'
  ClientHeight = 750
  ClientWidth = 1633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1633
    750)
  TextHeight = 13
  object grpProvince: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 734
    Anchors = [akLeft, akTop, akBottom]
    Caption = '1'#12289#30465#25110#30452#36758#24066#65306
    DefaultHeaderFont = False
    HeaderFont.Charset = GB2312_CHARSET
    HeaderFont.Color = clWhite
    HeaderFont.Height = -27
    HeaderFont.Name = #23435#20307
    HeaderFont.Style = [fsBold]
    TabOrder = 0
    ExplicitHeight = 644
    DesignSize = (
      249
      734)
    object cbbProvince: TListBox
      Left = 8
      Top = 37
      Width = 230
      Height = 687
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 3947580
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 27
      ParentFont = False
      TabOrder = 0
      OnClick = cbbProvinceChange
      ExplicitHeight = 597
    end
  end
  object grpCity: TGroupBox
    Left = 272
    Top = 8
    Width = 273
    Height = 734
    Anchors = [akLeft, akTop, akBottom]
    Caption = '2'#12289#24066#65306
    DefaultHeaderFont = False
    HeaderFont.Charset = GB2312_CHARSET
    HeaderFont.Color = clWhite
    HeaderFont.Height = -27
    HeaderFont.Name = #23435#20307
    HeaderFont.Style = [fsBold]
    TabOrder = 1
    DesignSize = (
      273
      734)
    object cbbCity: TListBox
      Left = 8
      Top = 37
      Width = 257
      Height = 687
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 3947580
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 27
      ParentFont = False
      TabOrder = 0
      OnClick = cbbCityChange
      ExplicitWidth = 353
      ExplicitHeight = 402
    end
  end
  object grpCity1: TGroupBox
    Left = 561
    Top = 8
    Width = 352
    Height = 734
    Anchors = [akLeft, akTop, akBottom]
    Caption = '3'#12289#21439'/'#21306#65306
    DefaultHeaderFont = False
    HeaderFont.Charset = GB2312_CHARSET
    HeaderFont.Color = clWhite
    HeaderFont.Height = -27
    HeaderFont.Name = #23435#20307
    HeaderFont.Style = [fsBold]
    TabOrder = 2
    DesignSize = (
      352
      734)
    object cbbArea: TListBox
      Left = 8
      Top = 37
      Width = 335
      Height = 687
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 3947580
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 27
      ParentFont = False
      TabOrder = 0
      OnClick = cbbAreaChange
      ExplicitWidth = 352
      ExplicitHeight = 133
    end
  end
  object grpCity2: TGroupBox
    Left = 928
    Top = 8
    Width = 347
    Height = 734
    Anchors = [akLeft, akTop, akBottom]
    Caption = '4'#12289#20065'/'#38215#65306
    DefaultHeaderFont = False
    HeaderFont.Charset = GB2312_CHARSET
    HeaderFont.Color = clWhite
    HeaderFont.Height = -27
    HeaderFont.Name = #23435#20307
    HeaderFont.Style = [fsBold]
    TabOrder = 3
    DesignSize = (
      347
      734)
    object cbbStreet: TListBox
      Left = 8
      Top = 37
      Width = 329
      Height = 687
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 3947580
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 27
      ParentFont = False
      TabOrder = 0
      OnClick = cbbStreetChange
      ExplicitHeight = 597
    end
  end
  object grpCity11: TGroupBox
    Left = 1288
    Top = 8
    Width = 337
    Height = 734
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = '5'#12289#23621#22996#20250#65306
    DefaultHeaderFont = False
    HeaderFont.Charset = GB2312_CHARSET
    HeaderFont.Color = clWhite
    HeaderFont.Height = -27
    HeaderFont.Name = #23435#20307
    HeaderFont.Style = [fsBold]
    TabOrder = 4
    ExplicitWidth = 343
    DesignSize = (
      337
      734)
    object cbbVillage: TListBox
      Left = 8
      Top = 37
      Width = 321
      Height = 687
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 3947580
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 27
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 353
      ExplicitHeight = 597
    end
  end
end
