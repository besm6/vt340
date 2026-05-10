//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Задание параметров для подключения SSH                 *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  28.03.2022                                  *
//* Изменение: 01.05.2022                                  *
//**********************************************************
//
unit UFormSettingSSH;
//
interface
//
uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ExtCtrls;
//
type
 TFormSettingSSH = class(TForm)
  LabeledEditSSHServerKey: TLabeledEdit;
  LabeledEditSSHLockPort: TLabeledEdit;
  LabelPrivateKeyFile: TLabel;
  MemoPrivateKeyFile: TMemo;
  ButtonOK: TButton;
  ButtonCancel: TButton;
//
  procedure FormActivate(Sender: TObject);
  private
   { Private declarations }
  public
   { Public declarations }
  end;
//
var
 FormSettingSSH: TFormSettingSSH;
//
implementation
//
{$R *.dfm}
//
// Активизация формы
// =================
procedure TFormSettingSSH.FormActivate(Sender: TObject);
var
NameFile //
         :  string;
begin
NameFile:=LabelPrivateKeyFile.Caption;
LabelPrivateKeyFile.Caption:='Файл закрытого ключа ('+NameFile+'):';
MemoPrivateKeyFile.Lines.Clear;
try
 MemoPrivateKeyFile.Lines.LoadFromFile(NameFile);
except
 Application.MessageBox(PAnsiChar('Не найден файл '+NameFile), 'Ошибка');
end;
end;
//
end.
