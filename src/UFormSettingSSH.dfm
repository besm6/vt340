object FormSettingSSH: TFormSettingSSH
  Left = 351
  Top = 127
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' SSH'
  ClientHeight = 294
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  DesignSize = (
    579
    294)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelPrivateKeyFile: TLabel
    Left = 8
    Top = 48
    Width = 123
    Height = 13
    Caption = #1060#1072#1081#1083' '#1079#1072#1082#1088#1099#1090#1086#1075#1086' '#1082#1083#1102#1095#1072':'
  end
  object LabeledEditSSHServerKey: TLabeledEdit
    Left = 8
    Top = 16
    Width = 465
    Height = 21
    EditLabel.Width = 74
    EditLabel.Height = 13
    EditLabel.Caption = #1050#1083#1102#1095' '#1089#1077#1088#1074#1077#1088#1072':'
    TabOrder = 2
  end
  object ButtonCancel: TButton
    Left = 496
    Top = 258
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 408
    Top = 258
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object LabeledEditSSHLockPort: TLabeledEdit
    Left = 480
    Top = 16
    Width = 89
    Height = 21
    EditLabel.Width = 87
    EditLabel.Height = 13
    EditLabel.Caption = #1051#1086#1082#1072#1083#1100#1085#1099#1081' '#1087#1086#1088#1090':'
    TabOrder = 3
  end
  object MemoPrivateKeyFile: TMemo
    Left = 8
    Top = 64
    Width = 561
    Height = 177
    Lines.Strings = (
      '')
    TabOrder = 4
  end
end
