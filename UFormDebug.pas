//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Вывод состояния Эмулятора(Отладчик)                    *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  06.02.2017                                  *
//* Изменение: 24.12.2021                                  *
//**********************************************************
//
unit UFormDebug;
//
interface
//
uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, MainCV;
//
type
 TFormDebug = class(TForm)
  Memo: TMemo;
  SaveDialog: TSaveDialog;
  ButtonClose: TButton;
  ButtonClear: TButton;
  ButtonSave: TButton;
//
  procedure FormActivate(Sender: TObject);
  procedure ButtonSaveClick(Sender: TObject);
  procedure ButtonClearClick(Sender: TObject);
  procedure ButtonCloseClick(Sender: TObject);
 private
  { Private declarations }
 public
  { Public declarations }
  procedure Write(Str :string);
 end;
//
var
 FormDebug: TFormDebug;
//
implementation
//
uses UFormMain;
//
{$R *.dfm}
//
// Запись информации
// =================
procedure TFormDebug.Write
 (Str // Выводимая строка
      :  string);
begin
if FormMain.MMNoOutput.Checked = false then
 Memo.Lines.Add(Str);
end;
//
// Активизация формы
// =================
procedure TFormDebug.FormActivate(Sender: TObject);
begin
//
end;
//
// Кнопка "Сохранить"
// ==================
procedure TFormDebug.ButtonSaveClick(Sender: TObject);
begin
if SaveDialog.Execute = false then Exit;
Memo.Lines.SaveToFile(SaveDialog.FileName);
end;
//
// Кнопка "Очистить"
// =================
procedure TFormDebug.ButtonClearClick(Sender: TObject);
begin
Memo.Clear;
end;
//
// Кнопка "Закрыть"
// ================
procedure TFormDebug.ButtonCloseClick(Sender: TObject);
begin
Close;
end;
//
end.
