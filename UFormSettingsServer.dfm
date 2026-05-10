object FormSettingsServer: TFormSettingsServer
  Left = 261
  Top = 60
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1089#1077#1088#1074#1077#1088#1072
  ClientHeight = 502
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  DesignSize = (
    372
    502)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonCancel: TButton
    Left = 288
    Top = 470
    Width = 75
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBoxServers: TGroupBox
    Left = 8
    Top = 136
    Width = 353
    Height = 273
    Caption = ' '#1057#1077#1088#1074#1077#1088#1072' '
    TabOrder = 3
    object LabelListServers: TLabel
      Left = 8
      Top = 96
      Width = 91
      Height = 13
      Caption = #1057#1087#1080#1089#1086#1082' '#1089#1077#1088#1074#1077#1088#1086#1074':'
    end
    object ButtonLoad: TButton
      Left = 272
      Top = 112
      Width = 75
      Height = 25
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 5
      OnClick = ButtonLoadClick
    end
    object ButtonSave: TButton
      Left = 272
      Top = 240
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 9
      OnClick = ButtonSaveClick
    end
    object ButtonDelete: TButton
      Left = 272
      Top = 144
      Width = 75
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 6
      OnClick = ButtonDeleteClick
    end
    object ListBoxServers: TListBox
      Left = 8
      Top = 112
      Width = 257
      Height = 153
      ItemHeight = 13
      TabOrder = 4
      OnClick = ListBoxServersClick
    end
    object LabeledEditPort: TLabeledEdit
      Left = 280
      Top = 72
      Width = 65
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1086#1088#1090':'
      TabOrder = 3
      OnChange = LabeledEditPortChange
    end
    object LabeledEditAdr: TLabeledEdit
      Left = 8
      Top = 72
      Width = 257
      Height = 21
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1076#1088#1077#1089':'
      TabOrder = 2
      OnChange = LabeledEditAdrChange
    end
    object LabeledEditName: TLabeledEdit
      Left = 8
      Top = 36
      Width = 153
      Height = 21
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = #1048#1084#1103':'
      TabOrder = 0
      OnChange = LabeledEditNameChange
    end
    object ButtonAdd: TButton
      Left = 272
      Top = 176
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 7
      OnClick = ButtonAddClick
    end
    object RadioGroupType: TRadioGroup
      Left = 176
      Top = 24
      Width = 169
      Height = 33
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '
      Columns = 2
      Items.Strings = (
        'Telnet'
        'SSH')
      TabOrder = 1
      OnClick = RadioGroupTypeClick
    end
    object ButtonSSH: TButton
      Left = 272
      Top = 208
      Width = 75
      Height = 25
      Caption = 'SSH'
      TabOrder = 8
      OnClick = ButtonSSHClick
    end
  end
  object CheckBoxDisconnect: TCheckBox
    Left = 24
    Top = 416
    Width = 137
    Height = 17
    Caption = #1054#1090#1082#1083#1102#1095#1072#1090#1100' '#1087#1088#1080' '#1074#1099#1093#1086#1076#1077
    TabOrder = 4
  end
  object GroupBoxServer: TGroupBox
    Left = 8
    Top = 16
    Width = 353
    Height = 113
    Caption = ' '#1042#1099#1073#1088#1072#1085#1085#1099#1081' '#1089#1077#1088#1074#1077#1088' '
    TabOrder = 2
    object LabeledEditGetPort: TLabeledEdit
      Left = 280
      Top = 80
      Width = 65
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1086#1088#1090':'
      TabOrder = 3
    end
    object LabeledEditGetName: TLabeledEdit
      Left = 8
      Top = 36
      Width = 153
      Height = 21
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = #1048#1084#1103':'
      TabOrder = 0
    end
    object LabeledEditGetAdr: TLabeledEdit
      Left = 8
      Top = 80
      Width = 257
      Height = 21
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1076#1088#1077#1089':'
      TabOrder = 2
    end
    object RadioGroupGetType: TRadioGroup
      Left = 176
      Top = 24
      Width = 169
      Height = 33
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '
      Columns = 2
      Items.Strings = (
        'Telnet'
        'SSH')
      TabOrder = 1
    end
  end
  object CheckBoxSetRaw: TCheckBox
    Left = 24
    Top = 440
    Width = 225
    Height = 17
    Caption = #1059#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1090#1100' RAW '#1087#1088#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1080
    TabOrder = 5
  end
  object ButtonOK: TButton
    Left = 200
    Top = 470
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    ModalResult = 2
    TabOrder = 0
    OnClick = ButtonOKClick
  end
end
