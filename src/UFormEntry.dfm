object FormEntry: TFormEntry
  Left = 1210
  Top = 153
  Width = 250
  Height = 140
  ActiveControl = LabeledEdit
  BorderIcons = []
  BorderStyle = bsSizeToolWin
  Caption = #1057#1090#1088#1072#1096#1085#1099#1081' '#1089#1085#1077#1078#1085#1099#1081' '#1073#1072#1088#1089' '#1088#1099#1095#1080#1090':'
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
    242
    113)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelWarning: TLabel
    Left = 8
    Top = 56
    Width = 178
    Height = 13
    Caption = #1047#1072#1073#1099#1083#1080' '#1087#1072#1088#1086#1083#1100'? '#1069#1090#1086' '#1087#1086#1095#1090#1080' '#1087#1080#1079#1076#1077#1094'!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
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
  object ButtonEntry: TButton
    Left = 160
    Top = 78
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1042#1086#1081#1090#1080
    Default = True
    TabOrder = 1
    OnClick = ButtonEntryClick
  end
  object Timer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerTimer
    Left = 112
    Top = 80
  end
end
