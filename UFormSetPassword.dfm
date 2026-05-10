object FormSetPassword: TFormSetPassword
  Left = 1688
  Top = 124
  Width = 250
  Height = 140
  BorderIcons = [biSystemMenu]
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1072#1088#1086#1083#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    242
    113)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelWarning: TLabel
    Left = 8
    Top = 56
    Width = 225
    Height = 13
    Caption = #1044#1086#1083#1078#1077#1085' '#1089#1086#1076#1077#1088#1078#1072#1090#1100' '#1085#1077' '#1084#1077#1085#1077#1077' 6 '#1089#1080#1084#1074#1086#1083#1086#1074
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object LabeledEdit: TLabeledEdit
    Left = 8
    Top = 24
    Width = 225
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1072#1088#1086#1083#1100':'
    TabOrder = 0
  end
  object ButtonSave: TButton
    Left = 72
    Top = 78
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object ButtonCancel: TButton
    Left = 159
    Top = 78
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
end
