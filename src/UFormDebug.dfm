object FormDebug: TFormDebug
  Left = 412
  Top = 135
  Width = 608
  Height = 450
  Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' ('#1086#1090#1083#1072#1076#1082#1072')'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  DesignSize = (
    600
    423)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 585
    Height = 377
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object ButtonClose: TButton
    Left = 520
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 0
    OnClick = ButtonCloseClick
  end
  object ButtonSave: TButton
    Left = 336
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight]
    Cancel = True
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ButtonClear: TButton
    Left = 424
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
    OnClick = ButtonClearClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt'
    Left = 16
    Top = 392
  end
end
