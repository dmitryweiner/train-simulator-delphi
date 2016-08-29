object Form1: TForm1
  Left = 146
  Top = 74
  BorderStyle = bsToolWindow
  Caption = 'Crazy Train'
  ClientHeight = 453
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 750
    Height = 450
  end
  object Timer1: TTimer
    Interval = 10
    OnTimer = Timer1Timer
  end
  object MainMenu1: TMainMenu
    Left = 32
    object N1: TMenuItem
      Caption = #1048#1075#1088#1072
      object N5: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1091#1088#1086#1074#1077#1085#1100
      end
      object N6: TMenuItem
        Caption = #1053#1072#1095#1072#1090#1100' '#1080#1075#1088#1091
      end
      object N7: TMenuItem
        Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1080#1075#1088#1091
      end
      object N8: TMenuItem
        Caption = #1055#1072#1091#1079#1072
      end
      object N9: TMenuItem
        Caption = #1042#1099#1093#1086#1076
      end
    end
    object N2: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object N3: TMenuItem
        Caption = #1054' '#1080#1075#1088#1077
      end
      object N4: TMenuItem
        Caption = #1055#1088#1072#1074#1080#1083#1072
      end
    end
    object N10: TMenuItem
      Caption = #1044#1077#1073#1072#1075
      object N11: TMenuItem
        Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1076#1077#1073#1072#1075
      end
    end
  end
end
