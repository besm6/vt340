//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Установка пароля                                       *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  06.12.2021                                  *
//* Изменение: 06.12.2021                                  *
//**********************************************************
//
unit UFormSetPassword;
//
interface
//
uses
 {$IFDEF MSWINDOWS}Windows,{$ENDIF} Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ExtCtrls;
//
type
 TFormSetPassword = class(TForm)
  LabeledEdit: TLabeledEdit;
  LabelWarning: TLabel;
  ButtonSave: TButton;
  ButtonCancel: TButton;
 private
 { Private declarations }
 public
 { Public declarations }
 end;
//
var
 FormSetPassword: TFormSetPassword;
//
implementation
//
{$R *.dfm}
//
end.
