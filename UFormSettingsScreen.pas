//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Задание параметров экрана                              *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  04.02.2017                                  *
//* Изменение: 26.04.2022                                  *
//**********************************************************
//
unit UFormSettingsScreen;
//
interface
//
uses
 {$IFDEF MSWINDOWS}Windows,{$ENDIF} Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ExtCtrls, Buttons, MainCV;
//
type
 TFormSettingsScreen = class(TForm)
  RadioGroupStyle: TRadioGroup;
  GroupBoxPrmAccurate: TGroupBox;
   LabelNumStr: TLabel;
   ComboBoxNumStr: TComboBox;
   EditNum: TEdit;
  GroupBoxModern: TGroupBox;
   CheckBoxClearScr: TCheckBox;
    CheckBoxLineSepIns: TCheckBox;
    LabeledEditLineSepSym: TLabeledEdit;
    LabeledEditLineSepNum: TLabeledEdit;
  GroupBoxScreen: TGroupBox;
   LabeledEditColScr: TLabeledEdit;
   ButtonCS: TButton;
   LabeledEditFontScr: TLabeledEdit;
   ButtonFont: TButton;
   LabelShowCtrl: TLabel;
   ComboBoxShowCtrl: TComboBox;
   LabeledEditTBlink: TLabeledEdit;
  GroupBoxKeyboard: TGroupBox;
   ComboBoxKeyboard: TComboBox;
   CheckBoxAddCtrlE: TCheckBox;
   CheckBoxAckERASE: TCheckBox;
  GroupBoxEdit: TGroupBox;
   LabeledEditEdit: TLabeledEdit;
   ButtonEdit: TButton;
  CheckBoxStatusButton: TCheckBox;
  CheckBoxSavePrm: TCheckBox;
  CheckBoxPassword: TCheckBox;
  ButtonSetPassword: TButton;
  ButtonOK: TButton;
  ButtonCancel: TButton;
  FontDialog: TFontDialog;
  ColorDialog: TColorDialog;
  OpenDialog: TOpenDialog;
//
  procedure FormActivate(Sender: TObject);
  procedure RadioGroupStyleClick(Sender: TObject);
  procedure CheckBoxLineSepInsClick(Sender: TObject);
  procedure ComboBoxShowCtrlChange(Sender: TObject);
  procedure ButtonCSClick(Sender: TObject);
  procedure ButtonFontClick(Sender: TObject);
  procedure ButtonEditClick(Sender: TObject);
  procedure CheckBoxPasswordClick(Sender: TObject);
  procedure ButtonSetPasswordClick(Sender: TObject);
  procedure ButtonOKClick(Sender: TObject);
 private
  { Private declarations }
  SetPassword   // Установленный пароль
                :  string;
 public
  { Public declarations }
  Style         // Стиль отображения дисплея
                :  TStyleVT;
  NumStrScreen, // Число строк на экране
                // 0 - 16 строк
                // 1 - Задать число
                // 2 - По высоте окна
  NumStrScr     // Фактическое число строк на экране
                :  integer;
  ClearScr      // Очищать экран после SEND
                :  boolean;
  ColorScr      // Цвет экрана
                :  TColor;
  FontScr       // Шрифт экрана
                :  TFont;
  ShowCtrl,     // Отображение Ctrl-символов
  TimeBlink,    // Время отображения Ctrl-символов
  Keyboard      // Клавиатура
                :  integer;
  AddCtrlE,     // Добавлять Ctrl-E в конец строки
  AckERASE      // Подтверждение при ERASE
                :  boolean;
  Edit          // Файл редактора
                :  string;
  StatusButton, // Сохранять состояние нажатых кнопок
  SavePrmScr,   // Сохранять параметры экрана при выходе
  CheckPassword // Проверять пароль при входе
                :  boolean;
 end;
//
var
 FormSettingsScreen: TFormSettingsScreen;
//
implementation
//
uses
 UFormSetPassword;
//
{$R *.dfm}
//
// Активизация формы
// =================
procedure TFormSettingsScreen.FormActivate(Sender: TObject);
begin
RadioGroupStyle.ItemIndex:=integer(Style);
RadioGroupStyleClick(Sender);
ComboBoxNumStr.ItemIndex:=NumStrScreen;
EditNum.Text:=IntToStr(NumStrScr);
CheckBoxClearScr.Checked:=ClearScr;
CheckBoxLineSepIns.Checked:=LineSepIns;
CheckBoxLineSepInsClick(Sender);
LabeledEditLineSepSym.Text:=LineSepSym;
LabeledEditLineSepNum.Text:=IntToStr(LineSepNum);
LabeledEditColScr.Color:=ColorScr;
LabeledEditFontScr.Text:=FontScr.Name;
ComboBoxShowCtrl.ItemIndex:=ShowCtrl;
LabeledEditTBlink.Text:=IntToStr(TimeBlink);
ComboBoxKeyboard.ItemIndex:=Keyboard;
CheckBoxAddCtrlE.Checked:=AddCtrlE;
CheckBoxAckERASE.Checked:=AckERASE;
LabeledEditEdit.Text:=Edit;
CheckBoxStatusButton.Checked:=StatusButton;
CheckBoxSavePrm.Checked:=SavePrmScr;
CheckBoxPassword.Checked:=CheckPassword;
CheckBoxPasswordClick(Sender);
end;
//
// Изменение "Стиля эмуляции"
// ==========================
procedure TFormSettingsScreen.RadioGroupStyleClick(Sender: TObject);
begin
case RadioGroupStyle.ItemIndex of
0: // Точная эмуляция
 begin
 GroupBoxPrmAccurate.Enabled:=true;
 GroupBoxModern.Enabled:=false;
 LabelNumStr.Enabled:=true;
 ComboBoxNumStr.Enabled:=true;
 EditNum.Enabled:=true;
 Application.MessageBox('В режиме точной эмуляции есть ошибки', 'Предупреждение');
 end;
1: // Современная эмуляция
 begin
 GroupBoxPrmAccurate.Enabled:=false;
 GroupBoxModern.Enabled:=true;
 LabelNumStr.Enabled:=false;
 ComboBoxNumStr.Enabled:=false;
 EditNum.Enabled:=false;
 end;
 end; // case RadioGroupStyle.ItemIndex
end;
//
// Изменение "Параметры современной эмуляции - Вставлять разделитель строк"
// ========================================================================
procedure TFormSettingsScreen.CheckBoxLineSepInsClick(Sender: TObject);
begin
case CheckBoxLineSepIns.Checked of
true:
 begin
 LabeledEditLineSepSym.Enabled:=true;
 LabeledEditLineSepNum.Enabled:=true;
 end;
false:
 begin
 LabeledEditLineSepSym.Enabled:=false;
 LabeledEditLineSepNum.Enabled:=false;
 end;
end; // case CheckBoxLineSepIns.Enabled
end;
//
// Кнопка "Экран - Выбор цвета экрана"
// ===================================
procedure TFormSettingsScreen.ButtonCSClick(Sender: TObject);
begin
if ColorDialog.Execute = false then Exit;
LabeledEditColScr.Color:=ColorDialog.Color;
ColorScr:=LabeledEditColScr.Color;
end;
//
// Кнопка "Экран - Выбор шрифта"
// =============================
procedure TFormSettingsScreen.ButtonFontClick(Sender: TObject);
begin
FontDialog.Font:=FontScr;
if FontDialog.Execute = false then Exit;
LabeledEditFontScr.Text:=Font.Name;
FontScr:=FontDialog.Font;
end;
//
// Изменение поля "Экран - Отображать Ctrl"
// ========================================
procedure TFormSettingsScreen.ComboBoxShowCtrlChange(Sender: TObject);
begin
if ComboBoxShowCtrl.ItemIndex = 0
 then LabeledEditTBlink.Enabled:=true
 else LabeledEditTBlink.Enabled:=false;
end;
//
// Кнопка "Редактор - Выбор имени файла"
// =====================================
procedure TFormSettingsScreen.ButtonEditClick(Sender: TObject);
begin
if OpenDialog.Execute = false then Exit;
LabeledEditEdit.Text:=OpenDialog.FileName;
//ColorScr:=LabeledEditColScr.Color;
Edit:=OpenDialog.FileName;
end;
//
// Изменение "Проверять пароль при входе"
// ======================================
procedure TFormSettingsScreen.CheckBoxPasswordClick(Sender: TObject);
begin
if CheckBoxPassword.Checked = true
 then ButtonSetPassword.Enabled:=true
 else ButtonSetPassword.Enabled:=false;
end;
//
// Кнопка "Установить"
// ===================
procedure TFormSettingsScreen.ButtonSetPasswordClick(Sender: TObject);
begin
FormSetPassword.ShowModal;
if FormSetPassword.ModalResult = mrCancel then Exit;
SetPassword:=FormSetPassword.LabeledEdit.Text;
end;
//
// Кнопка "OK"
// ===========
procedure TFormSettingsScreen.ButtonOKClick(Sender: TObject);
begin
Style:=TStyleVT(RadioGroupStyle.ItemIndex);
NumStrScreen:=ComboBoxNumStr.ItemIndex;
NumStrScr:=StrToInt(EditNum.Text);
ClearScr:=CheckBoxClearScr.Checked;
LineSepIns:=CheckBoxLineSepIns.Checked;
if (Length(LabeledEditLineSepSym.Text) <> 1) or
   (StrToIntDef(LabeledEditLineSepNum.Text, -1) <= 0) then
 begin
 Application.MessageBox('В параметрах разделителя строк', 'Ошибка');
 Exit;
 end;
LineSepSym:=LabeledEditLineSepSym.Text[1];
LineSepNum:=StrToIntDef(LabeledEditLineSepNum.Text, 40);
ColorScr:=LabeledEditColScr.Color;
ShowCtrl:=ComboBoxShowCtrl.ItemIndex;
TimeBlink:=StrToInt(LabeledEditTBlink.Text);
Keyboard:=ComboBoxKeyboard.ItemIndex;
AddCtrlE:=CheckBoxAddCtrlE.Checked;
AckERASE:=CheckBoxAckERASE.Checked;
Edit:=LabeledEditEdit.Text;
StatusButton:=CheckBoxStatusButton.Checked;
SavePrmScr:=CheckBoxSavePrm.Checked;
CheckPassword:=CheckBoxPassword.Checked;
Password:=SetPassword;
ModalResult:=mrOK;
end;
//
end.
