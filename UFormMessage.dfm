object FormMessage: TFormMessage
  Left = 1091
  Top = 262
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
  ClientHeight = 311
  ClientWidth = 618
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabelMessage: TLabel
    Left = 8
    Top = 56
    Width = 61
    Height = 13
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077':'
  end
  object LabeledEdit: TLabeledEdit
    Left = 8
    Top = 24
    Width = 601
    Height = 21
    EditLabel.Width = 90
    EditLabel.Height = 13
    EditLabel.Caption = #1058#1077#1084#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103':'
    TabOrder = 2
  end
  object Memo: TMemo
    Left = 8
    Top = 72
    Width = 601
    Height = 201
    TabOrder = 3
  end
  object ButtonCancel: TButton
    Left = 536
    Top = 280
    Width = 73
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object ButtonSend: TButton
    Left = 448
    Top = 280
    Width = 73
    Height = 25
    Caption = #1054#1090#1086#1089#1083#1072#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
