object fGlav: TfGlav
  Left = 569
  Top = 8
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1058#1077#1083#1077#1092#1086#1085#1085#1086'-'#1072#1076#1088#1077#1089#1085#1099#1081' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082
  ClientHeight = 726
  ClientWidth = 421
  Color = 16770809
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000111111111111111111111110000000118
    7777777777777777777777000000010000000000000000000000008000000050
    FFFFFFFFFFFFFF7777777F00000007050FFFFFFFFFFF777777FFFF0000000009
    5088888888888888888FFF000000F015950FFFFF7777777FFFFFFF0000000709
    5950888888888888888FFF000000000595990777777777FFFFFFFF000000F019
    5959088888888888888FFF0000000705959907777777FFFFFFFFFF0000000009
    5959088888888888888FFF000000F0159599077777FFFFFFFFFFFF0000950709
    5959080888888888888FF0D9D9090005959907F00FFFF000000FF00D9D90F019
    59590880B0000FFFFF800880D9D0070595990FFF00FFFFFFFFFFFFFF0D900009
    5959088880000008FFFFFFFF09D0F01595990FFFF00B0F08FFFFFFFF0D900709
    595908888080B008FFFFFFFF09D0000995990FFFF0F80B08FFFFFFF000000000
    99590000000F80B0FFFFF00000000000099900000000F80B0FFF000000000000
    0099000000000FF0B00000000000000000090000000000000B00000000000000
    000000000000000000B00000000000000000000000000000000B000000000000
    00000000000000000000B00000000000000000000000000000000DD000000000
    000000000000000000000DD0000000000000000000000000000000000000FFFF
    FFFFE000003F8000001F8000000F8000000F0000000F0000000F0000000F0000
    000F0000000F0000000F0000000F0000000C0000000000000000000000000000
    00000000000000000000000000000000000000000001E000001FF07E007FF87F
    00FFFC7F81FFFE7FF8FFFFFFFC7FFFFFFE3FFFFFFF1FFFFFFF9FFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object lSpravka: TLabel
    Tag = -1
    Left = 267
    Top = 705
    Width = 152
    Height = 18
    Alignment = taCenter
    AutoSize = False
    Caption = 'F1 - '#1089#1087#1088#1072#1074#1082#1072
    DragCursor = crHandPoint
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = lSpravkaClick
  end
  object lPusto: TLabel
    Tag = -1
    Left = 188
    Top = 678
    Width = 75
    Height = 21
    Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1072#1081#1076#1077#1085#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1091#1089#1090#1086
    Color = clYellow
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
    Visible = False
  end
  object bDob: TButton
    Left = 190
    Top = 646
    Width = 77
    Height = 25
    Cursor = crHandPoint
    Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
    Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = bDobClick
  end
  object bIzm: TButton
    Left = 266
    Top = 646
    Width = 77
    Height = 25
    Cursor = crHandPoint
    Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
    Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = bIzmClick
  end
  object bUdal: TButton
    Left = 342
    Top = 646
    Width = 77
    Height = 25
    Cursor = crHandPoint
    Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
    Caption = '&'#1059#1076#1072#1083#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = bUdalClick
  end
  object bSohr: TButton
    Left = 215
    Top = 646
    Width = 85
    Height = 25
    Cursor = crHandPoint
    Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    Visible = False
    OnClick = bSohrClick
  end
  object bOtmena: TButton
    Left = 307
    Top = 646
    Width = 85
    Height = 25
    Cursor = crHandPoint
    Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    Visible = False
    OnClick = bOtmenaClick
  end
  object bPoryadok: TButton
    Left = 266
    Top = 676
    Width = 77
    Height = 25
    Cursor = crHandPoint
    Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1088#1103#1076#1086#1082' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
    Caption = '&'#1055#1086#1088#1103#1076#1086#1082
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = bPoryadokClick
  end
  object bNastroiki: TButton
    Left = 342
    Top = 676
    Width = 77
    Height = 25
    Cursor = crHandPoint
    Hint = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1074#1085#1077#1096#1085#1080#1081' '#1074#1080#1076' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Caption = '&'#1053#1072#1089#1090#1088#1086#1081#1082#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = bNastroikiClick
  end
  object cbPoisk: TComboBox
    Tag = -1
    Left = 4
    Top = 678
    Width = 179
    Height = 22
    Cursor = crHandPoint
    Hint = #1042#1099#1073#1086#1088' '#1087#1086#1083#1103', '#1087#1086' '#1082#1086#1090#1086#1088#1086#1084#1091#13#10#1073#1091#1076#1077#1090' '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1100#1089#1103' '#1087#1086#1080#1089#1082
    Style = csDropDownList
    Color = 14155221
    DropDownCount = 5
    ItemHeight = 14
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    Text = #1042#1089#1077' '#1087#1086#1083#1103
    OnChange = cbPoiskChange
    Items.Strings = (
      #1042#1089#1077' '#1087#1086#1083#1103
      #1048#1084#1103
      #1058#1077#1083#1077#1092#1086#1085#1099
      #1069#1083#1077#1082#1090#1088#1086#1085#1085#1072#1103' '#1087#1086#1095#1090#1072
      #1053#1086#1084#1077#1088'/'#1085#1080#1082' '#1042#1050#1086#1085#1090#1072#1082#1090#1077
      #1053#1086#1084#1077#1088' ICQ'
      #1053#1080#1082' '#1074' Skype'
      #1057#1090#1088#1072#1085#1080#1094#1072' '#1074' '#1080#1085#1077#1090#1077
      #1040#1076#1088#1077#1089' '#1087#1088#1086#1078#1080#1074#1072#1085#1080#1103
      #1040#1076#1088#1077#1089' '#1088#1072#1073#1086#1090#1099
      #1050#1086#1084#1087#1072#1085#1080#1103
      #1044#1086#1083#1078#1085#1086#1089#1090#1100
      #1044#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103
      #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1072)
  end
  object ePoisk: TEdit
    Tag = -1
    Left = 4
    Top = 703
    Width = 179
    Height = 20
    Hint = 
      #1055#1086#1083#1077' '#1074#1074#1086#1076#1072' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072#13#10#1053#1072#1095#1085#1080#1090#1077' '#1087#1080#1089#1072#1090#1100', '#1095#1090#1086#1073#1099' '#1085#1072#1095#1072#1090#1100' '#1087#1086#1080#1089#1082#13#10'('#1084#1080#1085#1080 +
      #1084#1091#1084' '#1076#1074#1072' '#1089#1080#1084#1074#1086#1083#1072')'
    AutoSize = False
    Color = 14155221
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    OnChange = ePoiskChange
  end
  object pN1: TPanel
    Tag = -1
    Left = 0
    Top = 0
    Width = 423
    Height = 167
    BevelInner = bvLowered
    Color = 16318433
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 4
      Width = 158
      Height = 14
      Caption = #1060#1072#1084#1080#1083#1080#1103', '#1048#1084#1103', '#1054#1090#1095#1077#1089#1090#1074#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label21: TLabel
      Left = 6
      Top = 44
      Width = 129
      Height = 14
      Caption = #1044#1086#1084#1072#1096#1085#1080#1081' '#1090#1077#1083#1077#1092#1086#1085
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label22: TLabel
      Left = 6
      Top = 84
      Width = 143
      Height = 14
      Caption = #1057#1086#1090#1086#1074#1099#1081' '#1090#1077#1083#1077#1092#1086#1085' '#8470'1'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label23: TLabel
      Left = 6
      Top = 124
      Width = 143
      Height = 14
      Caption = #1057#1086#1090#1086#1074#1099#1081' '#1090#1077#1083#1077#1092#1086#1085' '#8470'2'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label24: TLabel
      Left = 218
      Top = 84
      Width = 143
      Height = 14
      Caption = #1056#1072#1073#1086#1095#1080#1081' '#1090#1077#1083#1077#1092#1086#1085' '#8470'1'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label25: TLabel
      Left = 218
      Top = 124
      Width = 143
      Height = 14
      Caption = #1056#1072#1073#1086#1095#1080#1081' '#1090#1077#1083#1077#1092#1086#1085' '#8470'2'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object eFIO: TEdit
      Left = 6
      Top = 20
      Width = 411
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object eDomTel: TEdit
      Left = 6
      Top = 60
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object eSotTel1: TEdit
      Left = 6
      Top = 100
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object eSotTel2: TEdit
      Left = 6
      Top = 140
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object eRabTel1: TEdit
      Left = 218
      Top = 100
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object eRabTel2: TEdit
      Left = 218
      Top = 140
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
  end
  object pN2: TPanel
    Tag = 179
    Left = 0
    Top = 166
    Width = 423
    Height = 179
    BevelInner = bvLowered
    Color = 16318433
    TabOrder = 1
    object Label26: TLabel
      Left = 6
      Top = 16
      Width = 64
      Height = 14
      Caption = 'E-mail '#8470'1'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label27: TLabel
      Left = 6
      Top = 136
      Width = 114
      Height = 14
      Caption = #1051#1080#1095#1085#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label28: TLabel
      Left = 218
      Top = 16
      Width = 187
      Height = 14
      Caption = #1053#1086#1084#1077#1088' '#1080#1083#1080' '#1085#1080#1082' '#1074#1086' '#1042#1050#1086#1085#1090#1072#1082#1090#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label29: TLabel
      Left = 6
      Top = 56
      Width = 64
      Height = 14
      Caption = 'E-mail '#8470'2'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label30: TLabel
      Left = 6
      Top = 96
      Width = 64
      Height = 14
      Caption = 'E-mail '#8470'3'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label37: TLabel
      Left = 218
      Top = 56
      Width = 69
      Height = 14
      Caption = #1053#1086#1084#1077#1088' ICQ'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label38: TLabel
      Left = 218
      Top = 96
      Width = 77
      Height = 14
      Caption = #1053#1080#1082' '#1074' Skype'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object eMail1: TEdit
      Left = 6
      Top = 32
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object eStranica: TEdit
      Left = 6
      Top = 152
      Width = 411
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
    end
    object eVKont: TEdit
      Left = 218
      Top = 32
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object eMail2: TEdit
      Left = 6
      Top = 72
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object eMail3: TEdit
      Left = 6
      Top = 112
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object pRaz2: TPanel
      Left = 6
      Top = 6
      Width = 411
      Height = 5
      Cursor = crHandPoint
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100'/'#1088#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1087#1086#1083#1077
      BevelInner = bvLowered
      Color = clRed
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = pRaz2Click
    end
    object eICQ: TEdit
      Left = 218
      Top = 72
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object eSkype: TEdit
      Left = 218
      Top = 112
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
  end
  object pN3: TPanel
    Tag = 139
    Left = 0
    Top = 344
    Width = 423
    Height = 139
    BevelInner = bvLowered
    Color = 16318433
    TabOrder = 2
    object Label44: TLabel
      Left = 6
      Top = 16
      Width = 123
      Height = 14
      Caption = #1040#1076#1088#1077#1089' '#1087#1088#1086#1078#1080#1074#1072#1085#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label45: TLabel
      Left = 6
      Top = 56
      Width = 98
      Height = 14
      Caption = #1056#1072#1073#1086#1095#1080#1081' '#1072#1076#1088#1077#1089
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label46: TLabel
      Left = 6
      Top = 96
      Width = 63
      Height = 14
      Caption = #1050#1086#1084#1087#1072#1085#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label47: TLabel
      Left = 218
      Top = 96
      Width = 71
      Height = 14
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object pRaz3: TPanel
      Left = 6
      Top = 6
      Width = 411
      Height = 5
      Cursor = crHandPoint
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100'/'#1088#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1087#1086#1083#1077
      BevelInner = bvLowered
      Color = clRed
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = pRaz2Click
    end
    object eDomAdres: TEdit
      Left = 6
      Top = 32
      Width = 411
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object eRabAdres: TEdit
      Left = 6
      Top = 72
      Width = 411
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object eKompania: TEdit
      Left = 6
      Top = 112
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object eDolzhn: TEdit
      Left = 218
      Top = 112
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
  end
  object pN4: TPanel
    Tag = 161
    Left = 0
    Top = 482
    Width = 423
    Height = 161
    BevelInner = bvLowered
    Color = 16318433
    TabOrder = 3
    object Label52: TLabel
      Left = 6
      Top = 16
      Width = 102
      Height = 14
      Caption = #1044#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label53: TLabel
      Left = 6
      Top = 56
      Width = 195
      Height = 14
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object pRaz4: TPanel
      Left = 6
      Top = 6
      Width = 411
      Height = 5
      Cursor = crHandPoint
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100'/'#1088#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1087#1086#1083#1077
      BevelInner = bvLowered
      Color = clRed
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = pRaz2Click
    end
    object eDenRozhd: TEdit
      Left = 6
      Top = 32
      Width = 200
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object mDopInfa: TMemo
      Left = 6
      Top = 72
      Width = 411
      Height = 83
      BorderStyle = bsNone
      Color = 12647359
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object bNachalo: TButton
    Left = 10
    Top = 646
    Width = 29
    Height = 25
    Cursor = crHandPoint
    Hint = #1042' '#1085#1072#1095#1072#1083#1086
    Caption = '<-'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = bNachaloClick
  end
  object bNazad: TButton
    Left = 38
    Top = 646
    Width = 57
    Height = 25
    Cursor = crHandPoint
    Hint = #1053#1072#1079#1072#1076
    Caption = '&<<'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = bNazadClick
  end
  object bVpered: TButton
    Left = 94
    Top = 646
    Width = 57
    Height = 25
    Cursor = crHandPoint
    Hint = #1042#1087#1077#1088#1105#1076
    Caption = '>&>'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = bVperedClick
  end
  object bKonec: TButton
    Left = 150
    Top = 646
    Width = 29
    Height = 25
    Cursor = crHandPoint
    Hint = #1042' '#1082#1086#1085#1077#1094
    Caption = '->'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = bKonecClick
  end
  object bOchistit: TButton
    Left = 188
    Top = 702
    Width = 76
    Height = 23
    Cursor = crHandPoint
    Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1077' '#1087#1086#1080#1089#1082#1072
    Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    OnClick = bOchistitClick
  end
end
