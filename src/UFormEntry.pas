//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Проверка пароля                                        *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  05.12.2021                                  *
//* Изменение: 24.12.2021                                  *
//**********************************************************
//
unit UFormEntry;
//
interface
//
uses
 {$IFDEF MSWINDOWS}Windows,{$ENDIF} Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ExtCtrls, Inifiles, MainCV;
//
type
 TFormEntry = class(TForm)
  LabeledEdit: TLabeledEdit;
  LabelWarning: TLabel;
  ButtonEntry: TButton;
  Timer: TTimer;
//
  procedure FormActivate(Sender: TObject);
  procedure ButtonEntryClick(Sender: TObject);
  procedure TimerTimer(Sender: TObject);
//
  private
   { Private declarations }
  public
   { Public declarations }
   Attempt // Число попыток набора пароля
           :  integer;
  end;
//
var
 FormEntry: TFormEntry;
//
implementation
//
{$R *.dfm}
//
// Активизация формы
// =================
procedure TFormEntry.FormActivate(Sender: TObject);
begin
Attempt:=0;
LabelWarning.Caption:='';
end;
//
// Кнопка "Войти"
// ==============
procedure TFormEntry.ButtonEntryClick(Sender: TObject);
begin
if LabeledEdit.Text <> Password then
 begin
 Attempt:=Attempt+1;
 case Attempt of
 1:
  begin
  LabelWarning.Font.Color:=clTeal;
  LabelWarning.Caption:='Забыли пароль? Это почти пиздец!';
  end;
 2:
  begin
  LabelWarning.Font.Color:=clBlue;
  LabelWarning.Caption:='Забыли пароль? Это пиздец!';
  end;
 3:
  begin
  LabelWarning.Font.Color:=clRed;
  LabelWarning.Caption:='Забыли пароль? Это полный пиздец!';
  end;
 end; // case Attempt
 if Attempt = 3 then
  begin
  Timer.Enabled:=true;
  end;
 Exit;
 end;
Close;
Attempt:=0;
end;
//
// Таймер
// ======
procedure TFormEntry.TimerTimer(Sender: TObject);
begin
Close
end;
//
end.
