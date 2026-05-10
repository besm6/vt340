//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Вывод справки                                          *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  21.06.2021                                  *
//* Изменение: 15.11.2021                                  *
//**********************************************************
//
unit UFormHelp;
//
interface
//
uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
 IdTCPClient, IdGlobal, IdExplicitTLSClientServerBase, IdMessageClient, IdIMAP4,
 IdSMTPBase, IdSMTP, IdMessage, IdIOHandler, IdIOHandlerSocket,
 IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdServerIOHandler;
//
type
 TFormHelp = class(TForm)
  Memo: TMemo;
  ButtonEmailToAdm: TButton;
  ButtonEmailToDev: TButton;
  ButtonOK: TButton;
  IdIMAP4: TIdIMAP4;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
//
  procedure FormCreate(Sender: TObject);
  procedure ButtonEmailToAdmClick(Sender: TObject);
  procedure ButtonEmailToDevClick(Sender: TObject);
 private
  { Private declarations }
 public
  { Public declarations }
 end;
//
var
 FormHelp: TFormHelp;
//
implementation
//
uses UFormMessage;
//
{$R *.dfm}
//
// Создание формы
// ==============
procedure TFormHelp.FormCreate(Sender: TObject);
begin
try
Memo.Lines.LoadFromFile('Instr.txt');
except
end;
end;
//
// Кнопка "Сообщение администратору"
// =================================
procedure TFormHelp.ButtonEmailToAdmClick(Sender: TObject);
begin
// email to the administrator
//Application.MessageBox('Не релизовано'+CR+LF+'Чуть-чуть позже', 'NVMZ');
//exit;
FormMessage.ShowModal;
//
end;
//
// Кнопка "Сообщение разработчику"
// ===============================
procedure TFormHelp.ButtonEmailToDevClick(Sender: TObject);
var
IdMessage //
          :  TIdMessage;
SSLOpen   //
          :  TIdSSLIOHandlerSocketOpenSSL;
begin
try
IdSMTP.Connect;
except
Application.MessageBox('Подключение не удалось', 'Ошибка');
Exit;
end;
if IdSMTP.Connected = true then
 Application.MessageBox('Подключение есть', 'NVMZ');
FormMessage.ShowModal;
IdMessage:=TIdMessage.Create(Application);
//IdMessage.Body.Add('kkkk');
//IdMessage.Subject:='jjjj';

  SSLOpen := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  SSLOpen.Destination := IdSMTP.Host+':'+IntToStr(IdSMTP.Port);
  SSLOpen.Host := IdSMTP.Host;
  SSLOpen.Port := IdSMTP.Port;
  SSLOpen.DefaultPort := 0;
  SSLOpen.SSLOptions.Method := sslvSSLv23;
  SSLOpen.SSLOptions.Mode := sslmUnassigned;

  IdSMTP.IOHandler := SSLOpen;
  IdSMTP.UseTLS := utUseImplicitTLS;

  IdMessage.ContentType:='text/html; charset=windows-1251';
  IdMessage.Body.Text:='Привет из Delphi';
  IdMessage.Subject := 'Проверка почты';
  IdMessage.From.Address := 'nvmzvt-340@yandex.ru'; {&lt;&lt;Должно совпадать с SMTP.UserName}
  IdMessage.From.Name := 'Эмулятор VT-340';
  IdMessage.Recipients.EMailAddresses :='nvmz@yandex.ru';

//  IdSMTP.Connect;
//  if IdSMTP.Connected then
 IdSMTP.Send(IdMessage);

IdSMTP.Disconnect;
end;
//
end.
