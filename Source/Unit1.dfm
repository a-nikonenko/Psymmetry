object Form1: TForm1
  Left = 45
  Top = 157
  Width = 1210
  Height = 570
  Align = alCustom
  Caption = 'Contours 2.1 (c) 2014'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 400
    Height = 449
  end
  object PaintBox2: TPaintBox
    Left = 400
    Top = 0
    Width = 400
    Height = 449
  end
  object PaintBox3: TPaintBox
    Left = 800
    Top = 0
    Width = 400
    Height = 449
  end
  object Label6: TLabel
    Left = 175
    Top = 460
    Width = 52
    Height = 13
    Caption = 'Initial mask'
  end
  object Label7: TLabel
    Left = 540
    Top = 460
    Width = 114
    Height = 13
    Caption = 'Radial-asymmetric pixels'
  end
  object Label8: TLabel
    Left = 945
    Top = 460
    Width = 108
    Height = 13
    Caption = 'Point-asymmetric pixels'
  end
  object Panel1: TPanel
    Left = 0
    Top = 481
    Width = 1202
    Height = 55
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 130
      Top = 20
      Width = 3
      Height = 13
    end
    object Label2: TLabel
      Left = 220
      Top = 20
      Width = 3
      Height = 13
    end
    object Label3: TLabel
      Left = 320
      Top = 20
      Width = 3
      Height = 13
    end
    object Label4: TLabel
      Left = 420
      Top = 20
      Width = 3
      Height = 13
    end
    object Label5: TLabel
      Left = 520
      Top = 20
      Width = 3
      Height = 13
    end
    object Button1: TButton
      Left = 25
      Top = 15
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 168
    Top = 605
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 200
    Top = 605
  end
end
