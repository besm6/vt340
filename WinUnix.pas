//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Платформенозависимые функции                           *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  07.11.2021                                  *
//* Изменение: 11.11.2021                                  *
//**********************************************************
//
unit WinUnix;
//{$R-,T-,H+,X+}
//
interface
//
uses
 Windows, Messages, StdCtrls;
//
function GetFirstVisibleLine(var Memo: TMemo):integer;
procedure LineScroll(var Memo: TMemo; NumLine: integer);
procedure ScrollCaret(var Memo: TMemo);
procedure ScrollLineDown(var Memo: TMemo);
procedure ScrollLineUp(var Memo: TMemo);
//
implementation
//
//uses UFormMain;
//
// Получение первой видимой строки в редакторе
// ===========================================
function GetFirstVisibleLine
 (var Memo // Редактор
           :  TMemo)
 // Номер строки
 :  integer;
begin
{$IFDEF LINUX}
Result:=1;
{$ENDIF}
//
{$IFDEF MSWINDOWS}
Result:=Memo.Perform(EM_GETFIRSTVISIBLELINE, 0, 0);
{$ENDIF}
end;
//
// Прокрутка экрана в редакторе на заданное число строк
// ====================================================
procedure LineScroll
 (var Memo // Редактор
           :  TMemo;
  NumLine  // Номер строки
           :  integer);
begin
{$IFDEF LINUX}
Result:=1;
{$ENDIF}
//
{$IFDEF MSWINDOWS}
Memo.Perform(EM_LINESCROLL, 0, NumLine);
{$ENDIF}
end;
//
// Прокрутка экрана в редакторе до позиции курсора
// ===============================================
procedure ScrollCaret
 (var Memo // Редактор
           :  TMemo);
begin
{$IFDEF LINUX}
Result:=1;
{$ENDIF}
//
{$IFDEF MSWINDOWS}
Memo.Perform(EM_SCROLLCARET, 0, 0);
{$ENDIF}
end;
//
// Прокрутка экрана в редакторе на строку вниз
// ===========================================
procedure ScrollLineDown
 (var Memo // Редактор
           :  TMemo);
begin
{$IFDEF LINUX}
Result:=1;
{$ENDIF}
//
{$IFDEF MSWINDOWS}
Memo.Perform(EM_SCROLL, SB_LINEDOWN, 0);
{$ENDIF}
end;
//
// Прокрутка экрана в редакторе на строку вверх
// ============================================
procedure ScrollLineUP
 (var Memo // Редактор
           :  TMemo);
begin
{$IFDEF LINUX}
Result:=1;
{$ENDIF}
//
{$IFDEF MSWINDOWS}
Memo.Perform(EM_SCROLL, SB_LINEUP, 0);
{$ENDIF}
end;
//
end.
