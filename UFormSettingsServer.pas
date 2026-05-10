//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Задание параметров сервера                             *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  02.02.2017                                  *
//* Изменение: 02.05.2022                                  *
//**********************************************************
//
unit UFormSettingsServer;
//
interface
//
uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ExtCtrls, CheckLst, Inifiles, WinSock, MainCV;
//
type
 TFormSettingsServer = class(TForm)
  GroupBoxServer: TGroupBox;
   LabeledEditGetName: TLabeledEdit;
    RadioGroupGetType: TRadioGroup;
   LabeledEditGetAdr: TLabeledEdit;
   LabeledEditGetPort: TLabeledEdit;
  GroupBoxServers: TGroupBox;
   LabeledEditName: TLabeledEdit;
   RadioGroupType: TRadioGroup;
   LabeledEditAdr: TLabeledEdit;
   LabeledEditPort: TLabeledEdit;
   LabelListServers: TLabel;
   ListBoxServers: TListBox;
   ButtonLoad: TButton;
   ButtonDelete: TButton;
   ButtonAdd: TButton;
   ButtonSSH: TButton;
   ButtonSave: TButton;
  CheckBoxDisconnect: TCheckBox;
  CheckBoxSetRaw: TCheckBox;
  ButtonOK: TButton;
  ButtonCancel: TButton;
//
  procedure FormCreate(Sender: TObject);
  procedure FormActivate(Sender: TObject);
  procedure LabeledEditNameChange(Sender: TObject);
  procedure RadioGroupTypeClick(Sender: TObject);
  procedure LabeledEditAdrChange(Sender: TObject);
  procedure LabeledEditPortChange(Sender: TObject);
  procedure ListBoxServersClick(Sender: TObject);
  procedure ButtonLoadClick(Sender: TObject);
  procedure ButtonDeleteClick(Sender: TObject);
  procedure ButtonAddClick(Sender: TObject);
  procedure ButtonSSHClick(Sender: TObject);
  procedure ButtonSaveClick(Sender: TObject);
  procedure ButtonOKClick(Sender: TObject);
 private
  { Private declarations }
  ListType,        // Список типов подключения
  ListAddress,     // Список адресов серверов
  ListPort,        // Список портов серверов
  ListSSHServerKey,// Список ключей серверов
  ListSSHLockPort  // Список локальных портов серверов
                   :  TStrings;
  ServSSHServerKey,// Ключ сервера
  ServSSHLockPort  // Локальный порт сервера
                   :  string;
 public
  { Public declarations }
  NameServer    // Имя сервера по списку
                :  string;
  TypeConnect   // Тип подключения
                // 0 - Telnet
                // 1 - SSH
                :  integer;
  Address,      // Имя или адрес сервера
  Port,         // Номер порта
  SSHServerKey, // Ключ сервера
  SSHLockPort   // Локальный порт сервера
                :  string;
  Disconnect,   // Отключать от сервера при выходе
  SetRaw        // Устанавливать RAW при подключении
                :  boolean;
 end;
//
var
 FormSettingsServer: TFormSettingsServer;
//
implementation
//
uses UFormMain, UFormSettingSSH;
//
{$R *.dfm}
//
// Создание формы
// ==============
procedure TFormSettingsServer.FormCreate(Sender: TObject);
begin
ListType:=TStringList.Create;
ListAddress:=TStringList.Create;
ListPort:=TStringList.Create;
ListSSHServerKey:=TStringList.Create;
ListSSHLockPort:=TStringList.Create;
end;
//
// Активизация формы
// =================
procedure TFormSettingsServer.FormActivate(Sender: TObject);
var
FileSave // Файл параметров
         :  TIniFile;
Count,   // Счетчик параметров
NumList  // Число параметров
         :  integer;
ValuePrm // Значение параметра
         :  string;
begin
LabeledEditGetName.Text:=NameServer;
RadioGroupGetType.ItemIndex:=TypeConnect;
LabeledEditGetAdr.Text:=Address;
LabeledEditGetPort.Text:=Port;
CheckBoxDisconnect.Checked:=Disconnect;
CheckBoxSetRaw.Checked:=SetRaw;
//
FileSave:=TIniFile.Create(NameFileSave);
NumList:=FileSave.ReadInteger('List Servers', 'Count', 0);
ListBoxServers.Items.Clear;
for Count:=0 to NumList-1 do
 begin
 ValuePrm:=FileSave.ReadString('List Servers', 'Name['+IntToStr(Count)+']', '');
 ListBoxServers.Items.Add(ValuePrm);
 ValuePrm:=FileSave.ReadString('List Servers', 'Type['+IntToStr(Count)+']', '-1');
 ListType.Add(ValuePrm);
 ValuePrm:=FileSave.ReadString('List Servers', 'Address['+IntToStr(Count)+']', '');
 ListAddress.Add(ValuePrm);
 ValuePrm:=FileSave.ReadString('List Servers', 'Port['+IntToStr(Count)+']', '');
 ListPort.Add(ValuePrm);
 ValuePrm:=FileSave.ReadString('List Servers', 'SSHServerKey['+IntToStr(Count)+']', '');
 ListSSHServerKey.Add(ValuePrm);
 ValuePrm:=FileSave.ReadString('List Servers', 'SSHLockPort['+IntToStr(Count)+']', '');
 ListSSHLockPort.Add(ValuePrm);
 end;
ButtonSSH.Enabled:=false;
end;
//
// Изменение поля "Сервера - Имя"
// ==============================
procedure TFormSettingsServer.LabeledEditNameChange(Sender: TObject);
var
Index // Индекс выделенного элемента
      :  integer;
begin
Index:=ListBoxServers.ItemIndex;
if Index =-1 then Exit;
ListBoxServers.Items[Index]:=LabeledEditName.Text;
end;
//
// Изменение поля "Сервера - Подключение"
// ======================================
procedure TFormSettingsServer.RadioGroupTypeClick(Sender: TObject);
var
Index // Индекс выделенного элемента
      :  integer;
begin
case RadioGroupType.ItemIndex of
0: ButtonSSH.Enabled:=false;
1: ButtonSSH.Enabled:=true;
end; // case RadioGroupType.ItemIndex
Index:=ListBoxServers.ItemIndex;
if Index =-1 then Exit;
ListType.Strings[Index]:=IntToStr(RadioGroupType.ItemIndex);
end;
//
// Изменение поля "Сервера - Адрес"
// ================================
procedure TFormSettingsServer.LabeledEditAdrChange(Sender: TObject);
var
Index // Индекс выделенного элемента
      :  integer;
begin
Index:=ListBoxServers.ItemIndex;
if Index =-1 then Exit;
ListAddress.Strings[Index]:=LabeledEditAdr.Text;
end;
//
// Изменение поля "Сервера - Порт"
// ===============================
procedure TFormSettingsServer.LabeledEditPortChange(Sender: TObject);
var
Index // Индекс выделенного элемента
      :  integer;
begin
Index:=ListBoxServers.ItemIndex;
if Index =-1 then Exit;
ListPort.Strings[Index]:=LabeledEditPort.Text;
end;
//
// Нажатие мыши в поле "Сервера - Список серверов"
// ===============================================
procedure TFormSettingsServer.ListBoxServersClick(Sender: TObject);
var
Index // Индекс выделенного элемента
      :  integer;
begin
Index:=ListBoxServers.ItemIndex;
LabeledEditName.Text:=ListBoxServers.Items.Strings[Index];
RadioGroupType.ItemIndex:=StrToIntDef(ListType[Index], 0);
LabeledEditAdr.Text:=ListAddress[Index];
LabeledEditPort.Text:=ListPort[Index];
ServSSHServerKey:=ListSSHServerKey[Index];
ServSSHLockPort:=ListSSHLockPort[Index];
end;
//
// Кнопка "Сервера - Установить"
// =============================
procedure TFormSettingsServer.ButtonLoadClick(Sender: TObject);
begin
LabeledEditGetName.Text:=LabeledEditName.Text;
RadioGroupGetType.ItemIndex:=RadioGroupType.ItemIndex;
LabeledEditGetAdr.Text:=LabeledEditAdr.Text;
LabeledEditGetPort.Text:=LabeledEditPort.Text;
SSHServerKey:=ServSSHServerKey;
SSHLockPort:=ServSSHLockPort;
end;
//
// Кнопка "Сервера - Удалить"
// ==========================
procedure TFormSettingsServer.ButtonDeleteClick(Sender: TObject);
var
Index // Индекс выделенного элемента
      :  integer;
begin
Index:=ListBoxServers.ItemIndex;
if Index =-1 then Exit;
ListBoxServers.Items.Delete(Index);
ListType.Delete(Index);
ListAddress.Delete(Index);
ListPort.Delete(Index);
ListSSHServerKey.Delete(Index);
ListSSHLockPort.Delete(Index);
LabeledEditName.Text:='';
LabeledEditAdr.Text:='';
LabeledEditPort.Text:='';
ServSSHServerKey:='';
ServSSHLockPort:='';
end;
//
// Кнопка "Сервера - Добавить"
// ===========================
procedure TFormSettingsServer.ButtonAddClick(Sender: TObject);
begin
if (Trim(LabeledEditName.Text) = '') or
   (RadioGroupType.ItemIndex = -1) or
   (Trim(LabeledEditAdr.Text) = '') or
   (Trim(LabeledEditPort.Text) = '') then
 begin
 Application.MessageBox('Параметры не заданы', 'Ошибка');
 Exit;
 end;
ListBoxServers.Items.Add(Trim(LabeledEditName.Text));
ListType.Add(IntToStr(RadioGroupType.ItemIndex));
ListAddress.Add(Trim(LabeledEditAdr.Text));
ListPort.Add(Trim(LabeledEditPort.Text));
ListSSHServerKey.Add(ServSSHServerKey);
ListSSHLockPort.Add(ServSSHLockPort);
end;
//
// Кнопка "Сервера - SSH"
// ======================
procedure TFormSettingsServer.ButtonSSHClick(Sender: TObject);
var
Index // Индекс выделенного элемента
      :  integer;
begin
FormSettingSSH.LabeledEditSSHServerKey.Text:=ServSSHServerKey;
FormSettingSSH.LabeledEditSSHLockPort.Text:=ServSSHLockPort;
FormSettingSSH.LabelPrivateKeyFile.Caption:=LabeledEditName.Text+'.ppk';
FormSettingSSH.ShowModal;
if FormSettingSSH.ModalResult = mrCancel then Exit;
ServSSHServerKey:=FormSettingSSH.LabeledEditSSHServerKey.Text;
ServSSHLockPort:=FormSettingSSH.LabeledEditSSHLockPort.Text;
Index:=ListBoxServers.ItemIndex;
if Index =-1 then Exit;
ListSSHServerKey.Strings[Index]:=ServSSHServerKey;
ListSSHLockPort.Strings[Index]:=ServSSHLockPort;
end;
//
// Кнопка "Сервера - Сохранить"
// ============================
procedure TFormSettingsServer.ButtonSaveClick(Sender: TObject);
var
FileSave // Файл параметров
         :  TIniFile;
Count,   // Счетчик параметров
NumList  // Число параметров
         :  integer;
ValuePrm // Значение параметра
         :  string;
begin
FileSave:=TIniFile.Create(NameFileSave);
NumList:=ListBoxServers.Items.Count;
FileSave.WriteInteger('List Servers', 'Count', NumList);
for Count:=0 to NumList-1 do
 begin
 ValuePrm:=ListBoxServers.Items.Strings[Count];
 FileSave.WriteString('List Servers', 'Name['+IntToStr(Count)+']', ValuePrm);
 ValuePrm:=ListType[Count];
 FileSave.WriteString('List Servers', 'Type['+IntToStr(Count)+']', ValuePrm);
 ValuePrm:=ListAddress[Count];
 FileSave.WriteString('List Servers', 'Address['+IntToStr(Count)+']', ValuePrm);
 ValuePrm:=ListPort[Count];
 FileSave.WriteString('List Servers', 'Port['+IntToStr(Count)+']', ValuePrm);
 ValuePrm:=ListSSHServerKey[Count];
 FileSave.WriteString('List Servers', 'SSHServerKey['+IntToStr(Count)+']', ValuePrm);
 ValuePrm:=ListSSHLockPort[Count];
 FileSave.WriteString('List Servers', 'SSHLockPort['+IntToStr(Count)+']', ValuePrm);
 end;
end;
//
// Кнопка "OK"
// ===========
procedure TFormSettingsServer.ButtonOKClick(Sender: TObject);
begin
NameServer:=LabeledEditGetName.Text;
TypeConnect:=RadioGroupGetType.ItemIndex;
Address:=LabeledEditGetAdr.Text;
Port:=LabeledEditGetPort.Text;
Disconnect:=CheckBoxDisconnect.Checked;
SetRaw:=CheckBoxSetRaw.Checked;
ModalResult:=mrOK;
end;
//
end.
