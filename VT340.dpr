//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Основной модуль                                        *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  14.11.2016                                  *
//* Изменение: 05.11.2021                                  *
//**********************************************************
//
program VT340;
//
uses
  Forms,
  MainCV in 'MainCV.pas',
  UFormMain in 'UFormMain.pas' {FormMain},
  UFormSettingsServer in 'UFormSettingsServer.pas' {FormSettingsServer},
  UFormSettingsScreen in 'UFormSettingsScreen.pas' {FormSettingsScreen},
  UFormDebug in 'UFormDebug.pas' {FormDebug},
  UFormHelp in 'UFormHelp.pas' {FormHelp},
  UFormMessage in 'UFormMessage.pas' {FormMessage},
  WinUnix in 'WinUnix.pas',
  UFormEntry in 'UFormEntry.pas' {FormEntry},
  UFormSetPassword in 'UFormSetPassword.pas' {FormSetPassword},
  UFormSearch in 'UFormSearch.pas' {FormSearch},
  UFormSettingSSH in 'UFormSettingSSH.pas' {FormSettingSSH},
  UFormLanguage in 'UFormLanguage.pas' {FormLanguage};

//
{$R *.res}
//
begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormSettingsServer, FormSettingsServer);
  Application.CreateForm(TFormSettingsScreen, FormSettingsScreen);
  Application.CreateForm(TFormDebug, FormDebug);
  Application.CreateForm(TFormHelp, FormHelp);
  Application.CreateForm(TFormMessage, FormMessage);
  Application.CreateForm(TFormEntry, FormEntry);
  Application.CreateForm(TFormSetPassword, FormSetPassword);
  Application.CreateForm(TFormSearch, FormSearch);
  Application.CreateForm(TFormSettingSSH, FormSettingSSH);
  Application.CreateForm(TFormLanguage, FormLanguage);
  Application.Run;
end.
