//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Текст поиска                                           *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  27.01.2022                                  *
//* Изменение: 27.01.2022                                  *
//**********************************************************
//
unit UFormSearch;
//
interface
//
uses
 {$IFDEF MSWINDOWS}Windows,{$ENDIF} Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ExtCtrls;
//
type
 TFormSearch = class(TForm)
  LabeledEdit1: TLabeledEdit;
  ButtonOK: TButton;
  ButtonCancel: TButton;
    Button3: TButton;
  private
  { Private declarations }
  public
  { Public declarations }
  end;
//
var
 FormSearch: TFormSearch;
//
implementation
//
{$R *.dfm}
//
end.
