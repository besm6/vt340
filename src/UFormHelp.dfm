object FormHelp: TFormHelp
  Left = 219
  Top = 128
  ActiveControl = ButtonOK
  Anchors = [akLeft, akRight, akBottom]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1054' '#1069#1084#1091#1083#1103#1090#1086#1088#1077' VT-340'
  ClientHeight = 456
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 689
    Height = 409
    TabStop = False
    Lines.Strings = (
      #1047#1076#1077#1089#1100' '#1073#1091#1076#1077#1090' '#1095#1090#1086'-'#1090#1086' '#1085#1072#1087#1080#1089#1072#1085#1086'.'
      #1063#1091#1090#1100'-'#1095#1091#1090#1100' '#1087#1086#1079#1078#1077'.'
      '')
    ReadOnly = True
    TabOrder = 3
  end
  object ButtonOK: TButton
    Left = 600
    Top = 424
    Width = 81
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object ButtonEmailToAdm: TButton
    Left = 8
    Top = 424
    Width = 161
    Height = 25
    Cancel = True
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1091
    Default = True
    TabOrder = 1
    OnClick = ButtonEmailToAdmClick
  end
  object ButtonEmailToDev: TButton
    Left = 184
    Top = 423
    Width = 161
    Height = 25
    Cancel = True
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1091
    Default = True
    TabOrder = 2
    OnClick = ButtonEmailToDevClick
  end
  object IdIMAP4: TIdIMAP4
    Host = 'yandex1.ru'
    SASLMechanisms = <>
    MilliSecsToWaitToClearBuffer = 10
    Left = 544
    Top = 424
  end
  object IdSMTP: TIdSMTP
    Host = 'smtp.yandex.ru'
    Password = 'msuvt340'
    SASLMechanisms = <>
    Username = 'nvmzvt-340@yandex.ru'
    Left = 496
    Top = 424
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 448
    Top = 424
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 400
    Top = 424
  end
end
