object Form1: TForm1
  Left = 264
  Top = 122
  Width = 461
  Height = 339
  Caption = 'lab 9 Rouda 453504'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 449
    Height = 305
    ActivePage = Graph
    TabOrder = 0
    object Graph: TTabSheet
      Caption = 'Input'
      ImageIndex = 1
      DesignSize = (
        441
        277)
      object Label1: TLabel
        Left = 168
        Top = 16
        Width = 113
        Height = 13
        Caption = 'Enter sides of a triangle:'
      end
      object Label2: TLabel
        Left = 176
        Top = 58
        Width = 14
        Height = 13
        Anchors = [akLeft]
        Caption = 'AB'
      end
      object Label3: TLabel
        Left = 176
        Top = 80
        Width = 14
        Height = 13
        Caption = 'BC'
      end
      object Label4: TLabel
        Left = 176
        Top = 104
        Width = 14
        Height = 13
        Caption = 'AC'
      end
      object Label6: TLabel
        Left = 192
        Top = 192
        Width = 80
        Height = 13
        Caption = 'Scale Coefficient'
      end
      object Edit1: TEdit
        Left = 200
        Top = 56
        Width = 73
        Height = 21
        TabOrder = 0
        Text = '60'
      end
      object Edit2: TEdit
        Left = 200
        Top = 80
        Width = 73
        Height = 21
        TabOrder = 1
        Text = '80'
      end
      object Edit3: TEdit
        Left = 200
        Top = 104
        Width = 73
        Height = 21
        TabOrder = 2
        Text = '100'
      end
      object Button1: TButton
        Left = 8
        Top = 232
        Width = 113
        Height = 25
        Caption = 'Check existence'
        TabOrder = 3
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 176
        Top = 232
        Width = 113
        Height = 25
        Caption = 'Graph Triangle'
        TabOrder = 4
        OnClick = Button2Click
      end
      object BitBtn1: TBitBtn
        Left = 336
        Top = 232
        Width = 97
        Height = 25
        TabOrder = 5
        Kind = bkClose
      end
      object TrackBar1: TTrackBar
        Left = 120
        Top = 152
        Width = 217
        Height = 33
        Position = 5
        TabOrder = 6
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Graph'
      ImageIndex = 1
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 441
        Height = 265
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'About'
      ImageIndex = 2
      object Label5: TLabel
        Left = 152
        Top = 128
        Width = 119
        Height = 13
        Caption = 'Program draws a triangle '
      end
    end
  end
end
