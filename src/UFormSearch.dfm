object FormSearch: TFormSearch
  Left = 1211
  Top = 258
  Anchors = [akRight, akBottom]
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 99
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    324
    99)
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 24
    Width = 265
    Height = 21
    EditLabel.Width = 72
    EditLabel.Height = 13
    EditLabel.Caption = #1058#1077#1082#1089#1090' '#1087#1086#1080#1089#1082#1072';'
    TabOrder = 0
  end
  object ButtonOK: TButton
    Left = 152
    Top = 64
    Width = 73
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object ButtonCancel: TButton
    Left = 240
    Top = 64
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 288
    Top = 24
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 3
  end
end
