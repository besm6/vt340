object FormSettingsScreen: TFormSettingsScreen
  Left = 491
  Top = 371
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 
    #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1101#1082#1088#1072#1085#1072' '#1080' '#1082#1083#1072#1074#1080#1072#1090#1091#1088#1099' (Screen and keyboard se' +
    'ttings) '
  ClientHeight = 607
  ClientWidth = 322
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
    322
    607)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonCancel: TButton
    Left = 242
    Top = 580
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 154
    Top = 580
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object RadioGroupStyle: TRadioGroup
    Left = 8
    Top = 8
    Width = 305
    Height = 41
    Caption = ' '#1057#1090#1080#1083#1100' '#1101#1084#1091#1083#1103#1094#1080#1080'(Mode of emulation)'
    ItemIndex = 0
    Items.Strings = (
      #1058#1086#1095#1085#1072#1103' '#1101#1084#1091#1083#1103#1094#1080#1103'(Accurate)'
      #1057#1086#1074#1088#1077#1084#1077#1085#1085#1072#1103' '#1101#1084#1091#1083#1103#1094#1080#1103'(Modernized)')
    TabOrder = 2
    TabStop = True
    OnClick = RadioGroupStyleClick
  end
  object GroupBoxPrmAccurate: TGroupBox
    Left = 8
    Top = 56
    Width = 305
    Height = 65
    Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1090#1086#1095#1085#1086#1081' '#1101#1084#1091#1083#1103#1094#1080#1080' '
    TabOrder = 3
    TabStop = True
    object LabelNumStr: TLabel
      Left = 8
      Top = 16
      Width = 67
      Height = 13
      Caption = #1063#1080#1089#1083#1086' '#1089#1090#1088#1086#1082':'
    end
    object ComboBoxNumStr: TComboBox
      Left = 8
      Top = 32
      Width = 105
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '16 '#1089#1090#1088#1086#1082
        #1047#1072#1076#1072#1090#1100' '#1095#1080#1089#1083#1086
        #1055#1086' '#1074#1099#1089#1086#1090#1077' '#1086#1082#1085#1072)
    end
    object EditNum: TEdit
      Left = 128
      Top = 32
      Width = 41
      Height = 21
      TabOrder = 1
    end
  end
  object CheckBoxSavePrm: TCheckBox
    Left = 16
    Top = 512
    Width = 241
    Height = 20
    Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1101#1082#1088#1072#1085#1072' '#1087#1088#1080' '#1074#1099#1093#1086#1076#1077
    TabOrder = 9
  end
  object GroupBoxModern: TGroupBox
    Left = 8
    Top = 128
    Width = 305
    Height = 97
    Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1086#1074#1088#1077#1084#1077#1085#1085#1086#1081' '#1101#1084#1091#1083#1103#1094#1080#1080' '
    TabOrder = 4
    TabStop = True
    object CheckBoxClearScr: TCheckBox
      Left = 8
      Top = 16
      Width = 209
      Height = 17
      Caption = #1054#1095#1080#1097#1072#1090#1100' '#1101#1082#1088#1072#1085' '#1087#1086#1089#1083#1077' SEND'
      TabOrder = 0
    end
    object CheckBoxLineSepIns: TCheckBox
      Left = 8
      Top = 40
      Width = 177
      Height = 17
      Caption = #1042#1089#1090#1072#1074#1083#1103#1090#1100' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1089#1090#1088#1086#1082
      TabOrder = 1
      OnClick = CheckBoxLineSepInsClick
    end
    object LabeledEditLineSepSym: TLabeledEdit
      Left = 80
      Top = 64
      Width = 33
      Height = 21
      EditLabel.Width = 69
      EditLabel.Height = 13
      EditLabel.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100':'
      LabelPosition = lpLeft
      TabOrder = 2
    end
    object LabeledEditLineSepNum: TLabeledEdit
      Left = 216
      Top = 64
      Width = 33
      Height = 21
      EditLabel.Width = 88
      EditLabel.Height = 13
      EditLabel.Caption = #1063#1080#1089#1083#1086' '#1089#1080#1084#1074#1086#1083#1086#1074':'
      LabelPosition = lpLeft
      TabOrder = 3
    end
  end
  object CheckBoxStatusButton: TCheckBox
    Left = 16
    Top = 488
    Width = 241
    Height = 20
    Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1085#1072#1078#1072#1090#1099#1093' '#1082#1085#1086#1087#1086#1082
    TabOrder = 8
  end
  object CheckBoxPassword: TCheckBox
    Left = 16
    Top = 536
    Width = 177
    Height = 20
    Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1087#1088#1080' '#1074#1093#1086#1076#1077
    TabOrder = 10
    OnClick = CheckBoxPasswordClick
  end
  object ButtonSetPassword: TButton
    Left = 208
    Top = 535
    Width = 75
    Height = 28
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Default = True
    TabOrder = 11
    OnClick = ButtonSetPasswordClick
  end
  object GroupBoxKeyboard: TGroupBox
    Left = 8
    Top = 352
    Width = 305
    Height = 49
    Caption = ' '#1050#1083#1072#1074#1080#1072#1090#1091#1088#1072' '
    TabOrder = 6
    object ComboBoxKeyboard: TComboBox
      Left = 8
      Top = 20
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'WINDOWS'
        #1053#1042#1052#1047)
    end
    object CheckBoxAddCtrlE: TCheckBox
      Left = 104
      Top = 13
      Width = 193
      Height = 17
      Caption = #1044#1086#1073#1072#1074#1083#1103#1090#1100' Ctrl-E '#1074' '#1082#1086#1085#1077#1094' '#1089#1090#1088#1086#1082#1080
      TabOrder = 1
    end
    object CheckBoxAckERASE: TCheckBox
      Left = 104
      Top = 29
      Width = 193
      Height = 17
      Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077' '#1087#1088#1080' ERASE'
      TabOrder = 2
    end
  end
  object GroupBoxScreen: TGroupBox
    Left = 8
    Top = 232
    Width = 305
    Height = 113
    Caption = ' '#1069#1082#1088#1072#1085' '
    TabOrder = 5
    object LabelShowCtrl: TLabel
      Left = 8
      Top = 60
      Width = 83
      Height = 13
      Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' Ctrl:'
    end
    object LabeledEditColScr: TLabeledEdit
      Left = 8
      Top = 36
      Width = 73
      Height = 21
      BorderStyle = bsNone
      Color = clWhite
      EditLabel.Width = 67
      EditLabel.Height = 13
      EditLabel.Caption = #1062#1074#1077#1090' '#1101#1082#1088#1072#1085#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object ButtonCS: TButton
      Left = 96
      Top = 36
      Width = 25
      Height = 21
      Caption = '****'
      TabOrder = 1
      OnClick = ButtonCSClick
    end
    object LabeledEditFontScr: TLabeledEdit
      Left = 152
      Top = 40
      Width = 73
      Height = 17
      BorderStyle = bsNone
      EditLabel.Width = 76
      EditLabel.Height = 13
      EditLabel.Caption = #1064#1088#1080#1092#1090' '#1101#1082#1088#1072#1085#1072':'
      TabOrder = 2
    end
    object ButtonFont: TButton
      Left = 240
      Top = 36
      Width = 25
      Height = 21
      Caption = '****'
      TabOrder = 3
      OnClick = ButtonFontClick
    end
    object LabeledEditTBlink: TLabeledEdit
      Left = 152
      Top = 76
      Width = 97
      Height = 21
      EditLabel.Width = 100
      EditLabel.Height = 13
      EditLabel.Caption = #1042#1088#1077#1084#1103' '#1084#1080#1075#1072#1085#1080#1103' Ctrl:'
      TabOrder = 5
    end
    object ComboBoxShowCtrl: TComboBox
      Left = 8
      Top = 76
      Width = 129
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = ComboBoxShowCtrlChange
      Items.Strings = (
        #1052#1080#1075#1072#1085#1080#1077#1084
        #1055#1088#1086#1087#1080#1089#1085#1099#1084#1080' '#1073#1091#1082#1074#1072#1084#1080
        #1055#1088#1086#1073#1077#1083#1072#1084#1080)
    end
  end
  object GroupBoxEdit: TGroupBox
    Left = 8
    Top = 408
    Width = 305
    Height = 65
    Caption = ' '#1056#1077#1076#1072#1082#1090#1086#1088' '
    TabOrder = 7
    object ButtonEdit: TButton
      Left = 168
      Top = 36
      Width = 25
      Height = 21
      Caption = '****'
      TabOrder = 1
      OnClick = ButtonEditClick
    end
    object LabeledEditEdit: TLabeledEdit
      Left = 8
      Top = 36
      Width = 153
      Height = 21
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072':'
      TabOrder = 0
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 72
    Top = 576
  end
  object ColorDialog: TColorDialog
    Left = 104
    Top = 576
  end
  object OpenDialog: TOpenDialog
    Left = 40
    Top = 576
  end
end
