object Form1: TForm1
  Left = 391
  Top = 227
  Width = 386
  Height = 329
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 184
    Top = 72
    Width = 57
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 8
    Width = 145
    Height = 265
    ColCount = 2
    FixedCols = 0
    RowCount = 9
    TabOrder = 0
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object Edit1: TEdit
    Left = 176
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 176
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 248
    Top = 72
    Width = 49
    Height = 21
    TabOrder = 3
    Text = 'Edit3'
  end
  object BitButton4: TBitBtn
    Left = 168
    Top = 216
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkClose
  end
  object BitButton3: TBitBtn
    Left = 168
    Top = 248
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = BitButton3Click
  end
  object BitButton1: TBitBtn
    Left = 168
    Top = 136
    Width = 187
    Height = 25
    Caption = #1055#1077#1088#1077#1074#1077#1089#1090#1080' '#1074' '#1087#1086#1089#1090#1092#1080#1082#1089#1085#1091#1102' '#1092#1086#1088#1084#1091
    TabOrder = 6
    OnClick = BitButton1Click
  end
  object BitButton2: TBitBtn
    Left = 168
    Top = 176
    Width = 75
    Height = 25
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    TabOrder = 7
    OnClick = BitButton2Click
  end
  object Button1: TButton
    Left = 168
    Top = 104
    Width = 161
    Height = 25
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' (2)-'#1087#1088#1086#1074#1077#1088#1082#1072
    TabOrder = 8
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 272
    Top = 176
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 9
    OnClick = Button2Click
  end
end
