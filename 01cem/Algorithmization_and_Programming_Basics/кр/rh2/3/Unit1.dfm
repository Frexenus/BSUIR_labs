object Form1: TForm1
  Left = 381
  Top = 200
  Width = 1088
  Height = 563
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
    Left = 16
    Top = 48
    Width = 21
    Height = 13
    Caption = 'A = '
  end
  object Label2: TLabel
    Left = 16
    Top = 88
    Width = 17
    Height = 13
    Caption = 'B ='
  end
  object Label3: TLabel
    Left = 16
    Top = 120
    Width = 18
    Height = 13
    Caption = 'N ='
  end
  object Label4: TLabel
    Left = 16
    Top = 152
    Width = 19
    Height = 13
    Caption = 'M ='
  end
  object Edit1: TEdit
    Left = 48
    Top = 48
    Width = 137
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 48
    Top = 88
    Width = 137
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 48
    Top = 120
    Width = 137
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 48
    Top = 152
    Width = 137
    Height = 21
    TabOrder = 3
    Text = 'Edit4'
  end
  object Button1: TButton
    Left = 32
    Top = 200
    Width = 153
    Height = 73
    Caption = 'OK'
    TabOrder = 4
    OnClick = Button1Click
  end
  object chart2: TChart
    Left = 288
    Top = 48
    Width = 561
    Height = 289
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    View3D = False
    TabOrder = 5
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
end
