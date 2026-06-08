object fNastroiki: TfNastroiki
  Left = 399
  Top = 411
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 388
  ClientWidth = 305
  Color = 14998244
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bDobro: TButton
    Left = 29
    Top = 357
    Width = 83
    Height = 25
    Cursor = crHandPoint
    Caption = '&'#1044#1086#1073#1088#1086
    ModalResult = 1
    TabOrder = 1
  end
  object bOtmena: TButton
    Left = 111
    Top = 357
    Width = 83
    Height = 25
    Cursor = crHandPoint
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object bPrinyat: TButton
    Left = 195
    Top = 356
    Width = 83
    Height = 26
    Cursor = crHandPoint
    Caption = '&'#1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 0
    OnClick = bPrinyatClick
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 2
    Width = 297
    Height = 351
    Cursor = crHandPoint
    ActivePage = TabSheet2
    HotTrack = True
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076
      object lCv1: TLabel
        Left = 184
        Top = 231
        Width = 79
        Height = 47
        AutoSize = False
        Color = 14998244
        ParentColor = False
      end
      object bShZag: TButton
        Left = 0
        Top = 104
        Width = 141
        Height = 23
        Cursor = crHandPoint
        Caption = #1064#1088#1080#1092#1090' '#1079#1072#1075#1086#1083#1086#1074#1082#1072
        TabOrder = 0
        OnClick = bShZagClick
      end
      object bShPolDan: TButton
        Left = 0
        Top = 126
        Width = 141
        Height = 23
        Cursor = crHandPoint
        Caption = #1064#1088#1080#1092#1090' '#1087#1086#1083#1103' '#1076#1072#1085#1085#1099#1093
        TabOrder = 1
        OnClick = bShPolDanClick
      end
      object pPrimerF: TPanel
        Tag = -1
        Left = 36
        Top = 2
        Width = 214
        Height = 95
        Hint = #1054#1082#1085#1086
        BevelInner = bvLowered
        Color = 16770809
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        object pPrimer: TPanel
          Tag = -1
          Left = 1
          Top = 1
          Width = 212
          Height = 67
          Hint = #1041#1083#1086#1082' '#1076#1072#1085#1085#1099#1093
          BevelInner = bvLowered
          Color = 16318433
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object lPrimer: TLabel
            Left = 6
            Top = 7
            Width = 102
            Height = 14
            Hint = #1047#1072#1075#1086#1083#1086#1074#1086#1082
            Caption = #1044#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Transparent = True
          end
          object ePrimer: TEdit
            Left = 6
            Top = 24
            Width = 200
            Height = 21
            Hint = #1055#1086#1083#1077' '#1076#1072#1085#1085#1099#1093
            TabStop = False
            AutoSize = False
            BorderStyle = bsNone
            Color = 12647359
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 0
            Text = '1 '#1071#1085#1074#1072#1088#1103' 2000 '#1075#1086#1076#1072
          end
          object pPrimerR: TPanel
            Left = 5
            Top = 52
            Width = 202
            Height = 5
            Hint = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100
            BevelInner = bvLowered
            Color = clRed
            TabOrder = 1
            OnClick = bCvRazClick
          end
        end
        object ePrimerP: TEdit
          Left = 6
          Top = 73
          Width = 87
          Height = 17
          Hint = #1055#1086#1083#1077' '#1087#1086#1080#1089#1082#1072
          AutoSize = False
          Color = 14155221
          ReadOnly = True
          TabOrder = 1
          Text = #1055#1086#1080#1089#1082
        end
      end
      object bCvRaz: TButton
        Left = 144
        Top = 104
        Width = 141
        Height = 23
        Cursor = crHandPoint
        Caption = #1062#1074#1077#1090' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1103
        TabOrder = 3
        OnClick = bCvRazClick
      end
      object bCvPolDan: TButton
        Left = 144
        Top = 126
        Width = 141
        Height = 23
        Cursor = crHandPoint
        Caption = #1062#1074#1077#1090' '#1087#1086#1083#1103' '#1076#1072#1085#1085#1099#1093
        TabOrder = 4
        OnClick = bCvPolDanClick
      end
      object bCvBlDan: TButton
        Left = 144
        Top = 148
        Width = 141
        Height = 23
        Cursor = crHandPoint
        Caption = #1062#1074#1077#1090' '#1073#1083#1086#1082#1072' '#1076#1072#1085#1085#1099#1093
        TabOrder = 5
        OnClick = bCvBlDanClick
      end
      object bCvOkn: TButton
        Left = 144
        Top = 170
        Width = 141
        Height = 23
        Cursor = crHandPoint
        Caption = #1062#1074#1077#1090' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1086#1082#1085#1072
        TabOrder = 6
        OnClick = bCvOknClick
      end
      object bCvOknNastr: TButton
        Left = 0
        Top = 221
        Width = 177
        Height = 23
        Cursor = crHandPoint
        Caption = #1062#1074#1077#1090' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1086#1082#1086#1085
        TabOrder = 7
        OnClick = bCvOknNastrClick
      end
      object bCvPolSpisok: TButton
        Left = 0
        Top = 243
        Width = 177
        Height = 23
        Cursor = crHandPoint
        Caption = #1062#1074#1077#1090' '#1087#1086#1083#1103' '#1089#1087#1080#1089#1082#1072
        TabOrder = 8
        OnClick = bCvPolSpisokClick
      end
      object bShPolPoisk: TButton
        Left = 0
        Top = 148
        Width = 141
        Height = 23
        Cursor = crHandPoint
        Caption = #1064#1088#1080#1092#1090' '#1087#1086#1083#1077#1081' '#1087#1086#1080#1089#1082#1072
        TabOrder = 9
        OnClick = bShPolPoiskClick
      end
      object bCvPolPoisk: TButton
        Left = 144
        Top = 192
        Width = 141
        Height = 23
        Cursor = crHandPoint
        Caption = #1062#1074#1077#1090' '#1087#1086#1083#1077#1081' '#1087#1086#1080#1089#1082#1072
        TabOrder = 10
        OnClick = bCvPolPoiskClick
      end
      object lbPrimer: TListBox
        Left = 195
        Top = 244
        Width = 57
        Height = 21
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 14
        Items.Strings = (
          #1055#1088#1080#1084#1077#1088)
        ParentFont = False
        TabOrder = 11
      end
      object bShPolSpisok: TButton
        Left = 0
        Top = 265
        Width = 177
        Height = 23
        Cursor = crHandPoint
        Caption = #1064#1088#1080#1092#1090' '#1087#1086#1083#1103' '#1089#1087#1080#1089#1082#1072
        TabOrder = 12
        OnClick = bShPolSpisokClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1046#1077#1089#1090#1099
      ImageIndex = 1
      OnMouseMove = pChastotaMouseMove
      object Kartinka: TImage
        Left = 5
        Top = 168
        Width = 72
        Height = 36
        AutoSize = True
        Transparent = True
      end
      object pChastota: TPanel
        Left = 2
        Top = 6
        Width = 284
        Height = 51
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        OnMouseMove = pChastotaMouseMove
        object Label3: TLabel
          Left = 111
          Top = 4
          Width = 61
          Height = 18
          Caption = #1063#1072#1089#1090#1086#1090#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 2
          Top = 8
          Width = 36
          Height = 14
          Caption = #1042#1099#1096#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 244
          Top = 8
          Width = 36
          Height = 14
          Caption = #1053#1080#1078#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object tbChastota: TTrackBar
          Left = 1
          Top = 22
          Width = 282
          Height = 19
          Cursor = crHandPoint
          LineSize = 0
          Max = 100
          Min = 25
          Position = 25
          TabOrder = 0
          ThumbLength = 17
        end
      end
      object pDizpazon: TPanel
        Left = 2
        Top = 56
        Width = 284
        Height = 51
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        OnMouseMove = pChastotaMouseMove
        object Label1: TLabel
          Left = 105
          Top = 4
          Width = 74
          Height = 18
          Caption = #1044#1080#1072#1087#1072#1079#1086#1085
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 2
          Top = 8
          Width = 52
          Height = 14
          Caption = #1052#1077#1085#1100#1096#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 230
          Top = 8
          Width = 49
          Height = 14
          Caption = #1041#1086#1083#1100#1096#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object tbDiapazon: TTrackBar
          Left = 1
          Top = 22
          Width = 282
          Height = 19
          Cursor = crHandPoint
          LineSize = 0
          Max = 200
          TabOrder = 0
          ThumbLength = 17
        end
      end
      object stChuvstInfa: TStaticText
        Left = 4
        Top = 102
        Width = 279
        Height = 57
        AutoSize = False
        BevelInner = bvLowered
        BevelKind = bkSoft
        BevelOuter = bvRaised
        Caption = 
          '"'#1053#1072#1088#1080#1089#1091#1081#1090#1077'" '#1083#1102#1073#1086#1081' '#1080#1079' '#1078#1077#1089#1090#1086#1074', '#1080#1089#1087#1086#1083#1100#1079#1091#1102#1097#1080#1093#1089#1103' '#1074' '#1087#1088#1086#1075#1088#1072#1084#1084#1077', '#1095#1090#1086#1073#1099' '#1087 +
          #1086#1076#1086#1073#1088#1072#1090#1100' '#1095#1091#1074#1089#1090#1074#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1076#1083#1103' '#1089#1077#1073#1103'.'
        TabOrder = 2
        OnMouseMove = pChastotaMouseMove
      end
    end
  end
  object fd1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 226
  end
  object cd1: TColorDialog
    Left = 226
    Top = 28
  end
end
