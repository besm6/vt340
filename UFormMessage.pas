//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Подготовка сообщения                                   *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  21.06.2021                                  *
//* Изменение: 21.06.2021                                  *
//**********************************************************
//
unit UFormMessage;
//
interface
//
uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ExtCtrls;
//
type
 TFormMessage = class(TForm)
  LabeledEdit: TLabeledEdit;
  Memo: TMemo;
  LabelMessage: TLabel;
  ButtonCancel: TButton;
  ButtonSend: TButton;
 private
 { Private declarations }
 public
 { Public declarations }
 end;
//
var
 FormMessage: TFormMessage;
//
implementation
//
{$R *.dfm}
//
end.
