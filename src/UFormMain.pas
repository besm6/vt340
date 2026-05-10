//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Основная форма                                         *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский, А.П. Ильин          *
//* Создание:  14.11.2016                                  *
//* Изменение: 22.05.2024                                  *
//**********************************************************
//
unit UFormMain;
//
interface
//
uses
 {$IFDEF MSWINDOWS}Windows,{$ELSE}LCLIntf, LCLType,{$ENDIF}
 Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
 IdTelnet, IdGlobal, StdCtrls, Menus, ExtCtrls, ComCtrls, Buttons,
 Inifiles, ClipBrd, IdDNSResolver, MainCV, WinUnix
 {$IFDEF MSWINDOWS}, Printers, tlHelp32{$ENDIF}
 {$IFDEF LINUX}, Process{$ENDIF};
//
type
 TFormMain = class(TForm)
  Image: TImage;
  Memo: TMemo;
  Timer: TTimer;
  IdTelnet: TIdTelnet;
  IdDNSResolver: TIdDNSResolver;
  {$IFDEF MSWINDOWS}PrintDialog: TPrintDialog;{$ENDIF}
  MainMenu: TMainMenu;
   MMControl: TMenuItem;
    MMConnect: TMenuItem;
    MMDisconect: TMenuItem;
    MMControl1: TMenuItem;
    MMExit: TMenuItem;
   MMEdit: TMenuItem;
    MMDelete: TMenuItem;
    MMCopy: TMenuItem;
    MMCopyRus: TMenuItem;
    MMCopyLat: TMenuItem;
    MMCopyCtrl: TMenuItem;
    MMInsert: TMenuItem;
    MMInsertCtrl: TMenuItem;
    MMCallEdit: TMenuItem;
    MMSearch: TMenuItem;
    MMPrint: TMenuItem;
   MMSettings: TMenuItem;
    MMLanguage: TMenuItem;
    MMServer: TMenuItem;
    MMScreen: TMenuItem;
    MMSettings1: TMenuItem;
    MMSavePrm: TMenuItem;
    MMSettings2: TMenuItem;
    MMHelp: TMenuItem;
   MMDebug: TMenuItem;
    MMTimer: TMenuItem;
    MMNoOutput: TMenuItem;
    MMOutput: TMenuItem;
    MMScreenCopy: TMenuItem;
    MMScreenMemo: TMenuItem;
     MMUNICODE: TMenuItem;
     MMJCUKEN: TMenuItem;
     MMQWERTY: TMenuItem;
     MMRAW: TMenuItem;
     MMSHOW: TMenuItem;
    MMLayout: TMenuItem;
    MMIrbis: TMenuItem;
    MMGrayling: TMenuItem;
    MMGrayling1Connect: TMenuItem;
    MMGraylingStop: TMenuItem;
     MMGraylingTest1: TMenuItem;
     MMGraylingTest2: TMenuItem;
    MMShowLat: TMenuItem;
    MMAttack: TMenuItem;
     MMDDoS: TMenuItem;
     MMBlockTerm: TMenuItem;
     MMKeyUser: TMenuItem;
    MMDeb1: TMenuItem;
    MMDeb2: TMenuItem;
    MMDeb3: TMenuItem;
    MMDeb4: TMenuItem;
  PopupMenu: TPopupMenu;
   PMDelete: TMenuItem;
   PMCopy: TMenuItem;
   PMCopyRus: TMenuItem;
   PMCopyLat: TMenuItem;
   PMCopyCtrl: TMenuItem;
   PMInsert: TMenuItem;
   PMInsertCtrl: TMenuItem;
   PMSearch: TMenuItem;
   PM1: TMenuItem;
   PMPrint: TMenuItem;
  PopupMenuKey: TPopupMenu;
   PMKeyLat: TMenuItem;
   PMKeyRus: TMenuItem;
  PopupMenuMode: TPopupMenu;
   PMModeInsert: TMenuItem;
   PMModeOverwrite: TMenuItem;
  ButtonOFF: TButton;
  ButtonON: TButton;
  ButtonPrint: TButton;
  ButtonSend: TButton;
  ButtonMPON: TButton;
  ButtonPERR: TButton;
  ButtonROLL: TButton;
  ButtonUL: TButton;
  ButtonBLINK: TButton;
  ButtonErase: TButton;
  ButtonDL: TButton;
  ButtonIL: TButton;
  ButtonDC: TButton;
  ButtonIC: TButton;
  EditPos: TEdit;
  EditKey: TEdit;
  EditMode: TEdit;
//
  procedure FormCreate(Sender: TObject);
  procedure FormActivate(Sender: TObject);
  procedure FormClose(Sender: TObject; var Action: TCloseAction);
  procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
   MousePos: TPoint; var Handled: Boolean);
  procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
   MousePos: TPoint; var Handled: Boolean);
//
  procedure IdTelnetConnected(Sender: TObject);
  procedure IdTelnetDataAvailable(Sender: TIdTelnet; const Buffer: TIdBytes);
//
  procedure ImageClick(Sender: TObject);
//
  procedure MemoMouseDown(Sender: TObject; Button: TMouseButton;
   Shift: TShiftState; X, Y: Integer);
  procedure MemoKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure MemoKeyPress(Sender: TObject; var Key: Char);
  procedure MemoKeyUp(Sender: TObject; var Key: Word;
   Shift: TShiftState);
//
  procedure TimerTimer(Sender: TObject);
//
  procedure MMConnectClick(Sender: TObject);
  procedure MMDisconectClick(Sender: TObject);
  procedure MMExitClick(Sender: TObject);
  procedure MMDeleteClick(Sender: TObject);
  procedure MMCopyClick(Sender: TObject);
  procedure MMCopyRusClick(Sender: TObject);
  procedure MMCopyLatClick(Sender: TObject);
  procedure MMCopyCtrlClick(Sender: TObject);
  procedure MMInsertClick(Sender: TObject);
  procedure MMInsertCtrlClick(Sender: TObject);
  procedure MMCallEditClick(Sender: TObject);
  procedure MMSearchClick(Sender: TObject);
  procedure MMPrintClick(Sender: TObject);
  procedure MMServerClick(Sender: TObject);
  procedure MMScreenClick(Sender: TObject);
  procedure MMSavePrmClick(Sender: TObject);
  procedure MMHelpClick(Sender: TObject);
  procedure MMTimerClick(Sender: TObject);
  procedure MMNoOutputClick(Sender: TObject);
  procedure MMOutputClick(Sender: TObject);
  procedure MMScreenCopyClick(Sender: TObject);
  procedure MMScreenMemoClick(Sender: TObject);
  procedure MMUNICODEClick(Sender: TObject);
  procedure MMJCUKENClick(Sender: TObject);
  procedure MMQWERTYClick(Sender: TObject);
  procedure MMRAWClick(Sender: TObject);
  procedure MMSHOWClick(Sender: TObject);
  procedure MMLayoutClick(Sender: TObject);
  procedure MMIrbisClick(Sender: TObject);
//  procedure MMGraylingClick(Sender: TObject);
  procedure MMGrayling1ConnectClick(Sender: TObject);
  procedure MMGraylingStopClick(Sender: TObject);
  procedure MMGraylingTest1Click(Sender: TObject);
  procedure MMGraylingTest2Click(Sender: TObject);
  procedure MMShowLatClick(Sender: TObject);
  procedure MMDDoSClick(Sender: TObject);
  procedure MMBlockTermClick(Sender: TObject);
  procedure MMKeyUserClick(Sender: TObject);
  procedure MMDeb1Click(Sender: TObject);
  procedure MMDeb2Click(Sender: TObject);
  procedure MMDeb3Click(Sender: TObject);
  procedure MMDeb4Click(Sender: TObject);
//
  procedure PMDeleteClick(Sender: TObject);
  procedure PMCopyClick(Sender: TObject);
  procedure PMCopyRusClick(Sender: TObject);
  procedure PMCopyLatClick(Sender: TObject);
  procedure PMCopyCtrlClick(Sender: TObject);
  procedure PMInsertClick(Sender: TObject);
  procedure PMInsertCtrlClick(Sender: TObject);
  procedure PMPrintClick(Sender: TObject);
  procedure PMTimerClick(Sender: TObject);
  procedure PMOutputClick(Sender: TObject);
//
  procedure ButtonOFFClick(Sender: TObject);
  procedure ButtonOFFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonONClick(Sender: TObject);
  procedure ButtonONKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonSendClick(Sender: TObject);
  procedure ButtonSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonPrintClick(Sender: TObject);
  procedure ButtonPrintKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonMPONClick(Sender: TObject);
  procedure ButtonMPONKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonROLLClick(Sender: TObject);
  procedure ButtonROLLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonBLINKClick(Sender: TObject);
  procedure ButtonBLINKKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonEraseClick(Sender: TObject);
  procedure ButtonEraseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonDLClick(Sender: TObject);
  procedure ButtonDLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonILClick(Sender: TObject);
  procedure ButtonILKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonDCClick(Sender: TObject);
  procedure ButtonDCKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ButtonICClick(Sender: TObject);
  procedure ButtonICKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure EditPosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure EditKeyDblClick(Sender: TObject);
  procedure PMKeyLatClick(Sender: TObject);
  procedure PMKeyRusClick(Sender: TObject);
  procedure EditModeDblClick(Sender: TObject);
  procedure PMModeInsertClick(Sender: TObject);
  procedure PMModeOverwriteClick(Sender: TObject);
//
 private
  { Private declarations }
  GraylingTest //
               :  boolean;
  GraylingTime //
               :  integer;
  GraylingStr //
               :  string;
  ShowCtrl   // Выводить Ctrl-символы
             :  boolean;
  StrScreen  // Экран
             :  string;
  PosScr     // Позиция курсора на экране
             :  integer;
  T          // Время работы
             :  integer;
  StrSend    // Передаваемый текст
             :  string;
//++TimeUpdate:integer; ///// Разбираться!!!!!
//
  procedure ReadPrmScreen;
  procedure WritePrmServer;
  procedure ReadPrmServer;
  procedure WritePrmScreen;
  procedure WriteEditPos;
  procedure SetUnknownKeyboard;
  procedure SetLatKeyboard;
  procedure SetRusKeyboard;
  procedure SetInsertKeyboard;
  procedure SetOwerwriteKeyboard;
  function  KeyToSym(KeyIn:word{; State:integer; Shift:TShiftState}):char;
  function  KeyToSymNVMZ(KeyIn:word; CaseKeyboard:integer; Shift:TShiftState):char;
  procedure StrScreenToMemo(EndUpdate : boolean);
  procedure SetButton(Key:Word);
  procedure ClickButton(Key:Word);
 public
  { Public declarations }
 end;
//
var
 FormMain: TFormMain;
//
implementation
//
uses
UFormSettingsServer, UFormSettingsScreen, UFormDebug, UFormHelp,
UFormEntry, UFormSearch;
//
{$R *.dfm}
//
var
ClipBoard // Буфер обмена текста
          :  TClipboard;
//
// Перевод к нижнему регистру
// ==========================
function DownCase
 (Ch // Символ
     :  Char)
 : Char;
begin
Result:=Ch;
if Ch in ['A'..'Z'] then
 begin Result:=chr(ord(Ch)-ord('A')+ord('a')); Exit end;
if Ch in [#$C0..#$DF] then
 begin Result:=chr(ord(Ch)-$C0+$E0); Exit end;
end;
//
// Замена символа в строке
// =======================
procedure Replace
 (Ch      // Символ
          :  Char;
  var Str // Строка
          :  string;
  NumPos  // Номер позиции
          :  integer);
begin
if (Length(Str) = 0) or (NumPos > Length(Str)-1)
 then Str:=Str+Ch
 else Str[NumPos+1]:=Ch;
end;
//
// Поиск подстроки, начиная с заданной позиции
// ===========================================
function AnsiPosNum
 (const Substr, // Искомая подстрока
  S             // Поисковая строка
                :  string;
  FromPos       // Номер начальной позиции
                :  integer)
 // Номер найденной позиции
 :  integer;
var
P // Искомая строка
  :  PChar;
begin
Result:=0;
P:=AnsiStrPos(PChar(S)+FromPos-1, PChar(SubStr));
if P <> nil then
 Result:=integer(P)-integer(PChar(S))+1;
end;
//
// Перекодировка строки в латинские буквы
// ======================================
function StrToLat
 (const StrIn // Входная строка
              :  string)
 // Выходная строка
 :  string;
const
 RusLat: array [0..31] of char =
// А        Б        В        Г        Д        Е        Ж        З        И        Й        К        Л        М        Н        О        П
 ('A',    #$C1,    'B',    #$C3,    #$C4,    'E',    #$C6,    #$C7,    #$C8,    #$C9,    'K',    #$CB,    'M',    'H',    'O',    #$CF,
// Р        С        Т        У        Ф        Х        Ц        Ч        Ш        Щ        Ъ        Ы        Ь        Э        Ю        Я
  'P',    'C',    'T',    #$D3,    #$D4,    'X',    #$D6,    #$D7,    #$D8,    #$D9,    #$DA,    #$DB,    #$DC,    #$DD,    #$DE,    #$DF);
var
NumCh // Номер символа
      :  integer;
begin
Result:=StrIn;
for NumCh:=1 to Length(StrIn)-1 do
 if Result[NumCh] in [#$C0..#$DF] then
  Result[NumCh]:=RusLat[ord(Result[NumCh])-$C0];
end;
//
// Перекодировка строки в русские буквы
// ====================================
function StrToRus
 (const StrIn // Входная строка
              :  string)
 // Выходная строка
 :  string;
const
 LatRus: array [0..25] of char =
//  A        B        C        D   E        F   G   H        I   J   K        L   M
  (#$C0,    #$C2,    #$D1,    'D',#$C5,    'F','G',#$CD,    'I','J',#$CA,    'L',#$CC,
//  N   O        P        Q   R   S   T        U   V   W   X        Y   Z
   'N', #$CE,    #$D0,    'Q','R','S',#$D2,    'U','V','W',#$D5,    'Y','Z');
var
NumCh // Номер символа
      :  integer;
begin
Result:=StrIn;
for NumCh:=1 to Length(StrIn)-1 do
 if Result[NumCh] in ['A'..'Z'] then
  Result[NumCh]:=LatRus[ord(Result[NumCh])-$41];
end;
//
// Преобразование строки
// =====================
{function StrConvert
 (StrIn // Входная строка
              :  string)
 // Выходная строка
 :  string;
var
NumSym // Номер символа
       : integer;
begin
for NumSym:=1 to Length(StrIn)-1 do
 StrIn[NumSym]:=DownCase(StrIn[NumSym]);
for NumSym:=1 to Length(StrIn)-2 do
 if (StrIn[NumSym] = '!') and (StrIn[NumSym+1] in ['a'..'z',#$E0..#$FF]) then
  begin
  StrIn[NumSym]:=' ';
  StrIn[NumSym+1]:=chr(ord(StrIn[NumSym+1]) - $20)
  end;
Result:=StrIn;
end;
}
//
// Перевод байтового массива в шестнадиричную строку
// =================================================
function ByteArrayToHexString
 (const a //
          :  TIdBytes)
 //
 :  string;
var
i //
  :  integer;
s //
  :  string;
begin
s:='';
for i:=0 to Length(a)-1 do
 begin
 s:=s+Format('%.2X_',[a[i]]);
 if (i mod 16) = 15 then
 s:=s+CR+LF;
 end;
 Result:=s;
end;
//
// Перевод строки в шестнадиричную строку
// ======================================
function StrASCIIToHexString
 (const a //
          :  string)
 //
 :  string;
var
i //
  :  integer;
s //
  :  string;
c //
  :  char;
begin
s:='';
for i:=1 to Length(a) do
 begin
 c:=a[i];
 s:=s+Format('%.2X_',[integer(c)]);
 if (i mod 16) = 15 then
  s:=s+CR+LF;
 end;
Result:=s;
end;
//
// Перевод значения переменой типа TShiftState
// ===========================================
function ShiftStateToString
 (Shift //
        : TShiftState)
 //
 :  string;
//  TShiftState = set of (ssShift, ssAlt, ssCtrl,
//   ssLeft, ssRight, ssMiddle, ssDouble);
begin
Result:='';
if ssShift  in Shift then Result:=Result+'ssShift ';
if ssAlt    in Shift then Result:=Result+'ssAltt ';
if ssCtrl   in Shift then Result:=Result+'ssCtrl ';
if ssLeft   in Shift then Result:=Result+'ssLeft ';
if ssRight  in Shift then Result:=Result+'ssRight ';
if ssMiddle in Shift then Result:=Result+'ssMiddle ';
if ssDouble in Shift then Result:=Result+'ssDouble ';
end;
//
// Перевод символа в символ БЭСМ-6
// ===============================
function CharToBESM6
 (Key   // Входной символ
        :  char)
 // Выходной символ
 :  char;
const
SymToB6 // Таблица перекодировки символа в символ БЭСМ-6
        :  array [0..31] of byte =
        // А    Б    В    Г    Д    Е    Ж    З    И    Й
         ($61, $62, $77, $67, $64, $65, $76, $7A, $69, $6A,
        // К    Л    М    Н    О    П    Р    С    Т    У
          $6B, $6C, $6D, $6E, $6F, $70, $72, $73, $74, $75,
        // Ф    Х    Ц    Ч    Ш    Щ    Ъ    Ы    Ь    Э    Ю    Я
          $66, $68, $63, $7E, $7B, $7D, $00, $79, $78, $7C, $60, $71);
begin
Result:=Key;
if Key in ['a'..'z'] then // Ctrl
 begin
 Result:=chr(ord(Key)-ord('a')+1);
 Exit;
 end;
if Key in [#$C0..#$DF] then // Русские буквы
 begin
 Result:=chr(SymToB6[ord(Key)-$C0]);
 Exit;
 end;
end;
//
// Перевод строки в строку БЭСМ-6
// ==============================
function StrToBESM6
 (Str   // Входная строка
        :  string)
 // Выходная строка
 :  string;
var
NumSym // Номер символа
       :  integer;
begin
for NumSym:=1 to Length(Str) do
 Str[NumSym]:=CharToBESM6(Str[NumSym]);
StrToBESM6:=Str;
end;
//
// Перевод символа БЭСМ-6 в символ
// ===============================
function BESM6ToChar
 (Key // Входной символ
      :  char)
 // Выходные символы
 :  string;
const
B6ToSym // Таблица перекодировки символа БЭСМ-6 в символ
        :  array [0..31] of byte =
        // Ю    А    Б    Ц    Д    Е    Ф    Г    Х    И
         ($DE, $C0, $C1, $D6, $C4, $C5, $D4, $C3, $D5, $C8,
        // Й    К    Л    М    Н    О    П    Я    Р    С
          $C9, $CA, $CB, $CC, $CD, $CE, $CF, $DF, $D0, $D1,
        // Т    У    Ж    В    Ь    Ы    З    Ш    Э    Щ    Ч
          $D2, $D3, $C6, $C2, $DC, $DB, $C7, $D8, $DD, $D9, $D7, $00);
begin
Result:=Key;
if Key = LF then
 begin Result:='j'+CR+LF; Exit end;
if ord(Key) in [0..$1F] then
 begin Result:=chr(ord(Key)+$60); Exit end;
if ord(Key) in [$60..$7F] then
 begin Result:=chr(B6ToSym[integer(Key)-$60]); Exit end;
end;
//
// Перевод строки БЭСМ-6 в строку
// ==============================
function BESM6ToStr
 (Str   // Входная строка
        :  string)
 // Выходная строка
 :  string;
var
NumSym // Номер символа
       :  integer;
begin
Result:='';
for NumSym:=1 to Length(Str) do
 if (Str[NumSym] <> #0) and (Str[NumSym] <> #$7F) and (Str[NumSym] <> #$0D)then
  Result:=Result+BESM6ToChar(Str[NumSym]);
end;
//
// Добавление Ctrl-E, Ctrl-J в конец строки
// ========================================
// Только для Копировать-Вставить
function AddCtrlEJ
 (Str   // Входная строка
        :  string)
 // Выходная строка
 :  string;
var
NumSym // Номер символа
       :  integer;
begin
NumSym:=AnsiPosNum(CR+LF, Str, 1);
while NumSym <> 0 do
 begin
 if AddCtrlE = false
  then
   Insert('j', Str, NumSym)
  else
   begin
   Insert('ej', Str, NumSym);
   NumSym:=NumSym+1;
   end;
 NumSym:=AnsiPosNum(CR+LF, Str, NumSym+2);
 end;
AddCtrlEJ:=Str;
end;
//
// Запись параметров сервера
// =========================
procedure TFormMain.WritePrmServer;
var
FileSave // Файл параметров
         :  TIniFile;
begin
FileSave:=TIniFile.Create(NameFileSave);
FileSave.WriteString('Server', 'Name', NameServer);
FileSave.WriteInteger('Server', 'Type', TypeConnect);
FileSave.WriteString('Server', 'Address', Address);
FileSave.WriteString('Server', 'Port', Port);
FileSave.WriteString('Server', 'SSHServerKey', SSHServerKey);
FileSave.WriteString('Server', 'SSHLockPort', SSHLockPort);
FileSave.WriteBool('Server', 'Disconnect', Disconnect);
FileSave.WriteBool('Server', 'SetRaw', SetRaw);
end;
//
// Чтение параметров сервера
// =========================
procedure TFormMain.ReadPrmServer;
var
FileSave // Файл параметров
         :  TIniFile;
begin
FileSave:=TIniFile.Create(NameFileSave);
NameServer:=FileSave.ReadString('Server', 'Name', 'Что-то');
TypeConnect:=FileSave.ReadInteger('Server', 'Type', 0);
Address:=FileSave.ReadString('Server', 'Address', '93.180.5.93');
Port:=FileSave.ReadString('Server', 'Port', '4202');
SSHServerKey:=FileSave.ReadString('Server', 'SSHServerKey', '');
SSHLockPort:=FileSave.ReadString('Server', 'SSHLockPort', '4202');
Disconnect:=FileSave.ReadBool('Server', 'Disconnect', false);
SetRaw:=FileSave.ReadBool('Server', 'SetRaw', true);
end;
//
// Запись параметров экрана
// ========================
procedure TFormMain.WritePrmScreen;
var
FileSave // Файл параметров
         :  TIniFile;
begin
FileSave:=TIniFile.Create(NameFileSave);
FileSave.WriteInteger('Screen', 'Style', integer(Style));
FileSave.WriteInteger('Screen', 'NumStrScreen', NumStrScreen);
FileSave.WriteInteger('Screen', 'NumStrScr', NumStrScr);
FileSave.WriteBool('Screen', 'ClearScr', ClearScr);
FileSave.WriteBool('Screen', 'LineSepIns', LineSepIns);
FileSave.WriteInteger('Screen', 'LineSepSym', ord(LineSepSym));
FileSave.WriteInteger('Screen', 'LineSepNum', LineSepNum);
FileSave.WriteInteger('Screen', 'ColorScr', Memo.Color);
FileSave.WriteInteger('Screen', 'FontCharset', Memo.Font.Charset);
FileSave.WriteInteger('Screen', 'FontColor', Memo.Font.Color);
FileSave.WriteString('Screen', 'FontName', Memo.Font.Name);
FileSave.WriteInteger('Screen', 'FontSize', Memo.Font.Size);
FileSave.WriteInteger('Screen', 'ShowCtrl', TypeShowCtrl);
FileSave.WriteInteger('Screen', 'TCtrlBlink', TimeCtrlBlink);
FileSave.WriteInteger('Screen', 'Keyboard', Keyboard);
FileSave.WriteBool('Screen', 'AddCtrlE', AddCtrlE);
FileSave.WriteBool('Screen', 'AckERASE', AckERASE);
FileSave.WriteString('Screen', 'Edit', Edit);
FileSave.WriteBool('Screen', 'StatusButton', StatusButton);
FileSave.WriteBool('Screen', 'SavePrm', SavePrmScr);
FileSave.WriteBool('Screen', 'CheckPassword', CheckPassword);
FileSave.WriteString('Screen', 'Password', Password);
//
FileSave.WriteInteger('Screen', 'StatusMPON', ButtonMPON.Tag);
FileSave.WriteInteger('Screen', 'StatusROLL', ButtonROLL.Tag);
FileSave.WriteInteger('Screen', 'StatusBLINK', ButtonBLINK.Tag);
FileSave.WriteInteger('Screen', 'KeyboardCase', EditKey.Tag);
end;
//
// Чтение параметров экрана
// ========================
procedure TFormMain.ReadPrmScreen;
var
FileSave // Файл параметров
         :  TIniFile;
begin
FileSave:=TIniFile.Create(NameFileSave);
Style:=TStyleVT(FileSave.ReadInteger('Screen', 'Style', 0));
NumStrScreen:=FileSave.ReadInteger('Screen', 'NumStrScreen', 2);
NumStrScr:=FileSave.ReadInteger('Screen', 'NumStrScr', 16);
ClearScr:=FileSave.ReadBool('Screen', 'ClearScr', true);
LineSepIns:=FileSave.ReadBool('Screen', 'LineSepIns', false);
LineSepSym:=chr(FileSave.ReadInteger('Screen', 'LineSepSym', ord('e')));
LineSepNum:=FileSave.ReadInteger('Screen', 'LineSepNum', 20);
Memo.Color:=FileSave.ReadInteger('Screen', 'ColorScr', clWhite);
Memo.Font.Charset:=FileSave.ReadInteger('Screen', 'FontCharset', RUSSIAN_CHARSET);
Memo.Font.Color:=FileSave.ReadInteger('Screen', 'FontColor', clGreen);
Memo.Font.Name:=FileSave.ReadString('Screen', 'FontName', 'Courier New');
Memo.Font.Size:=FileSave.ReadInteger('Screen', 'FontSize', 12);
TypeShowCtrl:=FileSave.ReadInteger('Screen', 'ShowCtrl', 0);
TimeCtrlBlink:=FileSave.ReadInteger('Screen', 'TimeCtrlBlink', 5);
Keyboard:=FileSave.ReadInteger('Screen', 'Keyboard', 0);
AddCtrlE:=FileSave.ReadBool('Screen', 'AddCtrlE', true);
AckERASE:=FileSave.ReadBool('Screen', 'AckERASE', false);
Edit:=FileSave.ReadString('Screen', 'Edit', '');
StatusButton:=FileSave.ReadBool('Screen', 'StatusButton', false);
SavePrmScr:=FileSave.ReadBool('Screen', 'SavePrm', true);
CheckPassword:=FileSave.ReadBool('Screen', 'CheckPassword', false);
Password:=FileSave.ReadString('Screen', 'Password', '0000');
//
if StatusButton = true then
 begin
 StatusMPON:=FileSave.ReadBool('Screen', 'StatusMPON', false);
 if StatusMPON = true then ButtonMPONClick(Self);
 StatusROLL:=FileSave.ReadBool('Screen', 'StatusROLL', false);
 if StatusROLL = true then ButtonROLLClick(Self);
 StatusBLINK:=FileSave.ReadBool('Screen', 'StatusBLINK', false);
 if StatusBLINK = true then ButtonBLINKClick(Self);
 end;
EditKey.Tag:=FileSave.ReadInteger('Screen', 'KeyboardCase', 0);
end;
//
// Запись позиции курсора
// ======================
procedure TFormMain.WriteEditPos;
var
NumPos, ColNum,     // Номер позиции
CurrentLine // Номер строки
       :  integer;
Str    //
       :  string;
begin
// ТЕСТ
{$IFDEF MSWINDOWS}
CurrentLine:=SendMessage(memo.Handle,EM_LINEFROMCHAR, memo.SelStart, 0);
ColNum:= memo.SelStart-SendMessage(memo.Handle,EM_LINEINDEX,CurrentLine, 0) + 1;
{$ELSE}
CurrentLine:=Memo.CaretPos.Y;
ColNum:=Memo.CaretPos.X + 1;
{$ENDIF}
// StatusBar.Panels[0].Text;
// КОНТЕСТ
//EditPos.Text:=IntToStr(Memo.CaretPos.Y)+','+IntToStr(Memo.CaretPos.X)+  //Работает
// '/'+IntToStr(Memo.SelStart)+'['+IntToStr(PosScr)+']';
// '/'+IntToStr(Memo.SelStart); //Работает
Str:=Caption;
//NumPos:=Pos(' |', Str);  // Работает
//if NumPos <> 0 then Delete(Str, NumPos, Length(Str)); //Работает
// ТЕСТ
NumPos:=Pos(' |', Str);
if NumPos <> 0 then Delete(Str, NumPos, Length(Str));
Caption:=Str+' | '+ inttostr(CurrentLine)+':'+inttostr(ColNum)+
' Lэ='+IntToStr(Length(Memo.Text));
EditPos.Text:= inttostr(CurrentLine)+':'+inttostr(ColNum)+
' ['+IntToStr(Length(Memo.Text))+']';
//+' Lкэ='+IntToStr(Length(StrScreen));
end;
// КОНТЕСТ
//Caption:=Str+' | '+EditPos.Text+'['+IntToStr(PosScr)+']'+
//' Lэ='+IntToStr(Length(Memo.Text))+' Lкэ='+IntToStr(Length(StrScreen));
//end;
//
// Установка клавиатуры "WINDOWS"
// ==============================
procedure TFormMain.SetUnknownKeyboard;
begin
EditKey.Tag:=-1;
EditKey.Text:='СИС';
end;
//
// Установка латинской клавиатуры
// ==============================
procedure TFormMain.SetLatKeyboard;
begin
EditKey.Tag:=0;
PopupMenuKey.Items[0].Checked:=true;
PopupMenuKey.Items[1].Checked:=false;
EditKey.Text:='ЛАТ';
end;
//
// Установка русской клавиатуры
// ============================
procedure TFormMain.SetRusKeyboard;
begin
EditKey.Tag:=1;
PopupMenuKey.Items[0].Checked:=false;
PopupMenuKey.Items[1].Checked:=true;
EditKey.Text:='РУС';
end;
//
// Установка режима клавиатуры вставить
// ====================================
procedure TFormMain.SetInsertKeyboard;
begin
EditMode.Tag:=0;
PopupMenuMode.Items[0].Checked:=true;
PopupMenuMode.Items[1].Checked:=false;
EditMode.Text:='ВСТ';
end;
//
// Установка режима клавиатуры заменить
// ====================================
procedure TFormMain.SetOwerwriteKeyboard;
begin
EditMode.Tag:=1;
PopupMenuMode.Items[0].Checked:=false;
PopupMenuMode.Items[1].Checked:=true;
EditMode.Text:='ЗАМ';
end;
//
// Перевод принятого символа с клавиатуры в символ
// ===============================================
function TFormMain.KeyToSym
 (KeyIn // Принятый символ с клавиатуры
        :  word)
 // Выходной символ
 :  char;
var
Key // Принятый символ
    :  char;
begin
Result:=chr(KeyIn);
Key:=chr(KeyIn);
if Key in ['a'..'z'] then
 Result:=UpCase(Key);
if Key in [#$E0..#$FF] then
 Result:=chr(ord(Key)-$20);
if ord(Key) in [$01..$1A] then
 Result:=chr(ord(Key)+$60);
if Result = 'm' then
 Result:='c';
end;
//
// Перевод принятого символа с клавиатуры в символ НВМЗ
// ====================================================
function TFormMain.KeyToSymNVMZ
 (KeyIn        // Принятый символ с клавиатуры
               :  word;
  CaseKeyboard // Регистр клавиатуры
               :  integer;
  Shift        // Состояние клавиш
               :  TShiftState)
 // Выходной символ
 :  char;
const
KeyToNVMZ1  // Таблица перекодировки первого ряда
            :  array [0..13, 0..2] of char =
 (('`','~','~'), ('1','!','!'), ('2','@','"'), ('3','#',#$B9), ('4','$',';'),
  ('5','%','%'), ('6','^',':'), ('7','&','?'), ('8','*','*'), ('9','(','('),
  ('0',')',')'), ('-','_','_'), ('=','+','+'), (#08,#08,#08));
KeyToNVMZ24 // Таблица перекодировки 2,3,4-го рядов
            :  array [0..35, 0..2] of char =
 (('Q',#$C9,'q'), ('W',#$D6,'w'), ('E',#$D3,'e'), ('R',#$CA,'r'), ('T',#$C5,'t'),
  ('Y',#$CD,'y'), ('U',#$C3,'u'), ('I',#$D8,'i'), ('O',#$D9,'o'), ('P',#$C7,'p'),
  ('[',#$D5,'{'), (']',#$DA,'}'), ('\','|','/'), ('A',#$D4,'a'), ('S',#$DB,'s'),
  ('D',#$C2,'d'), ('F',#$C0,'f'), ('G',#$CF,'g'), ('H',#$D0,'h'), ('J',#$CE,'j'),
  ('K',#$CB,'k'), ('L',#$C4,'l'), (';',#$C6,':'), ('''',#$DD,'"'),('Z',#$DF,'z'),
  ('X',#$D7,'x'), ('C',#$D1,'c'), ('V',#$CC,'v'), ('B',#$C8,'b'), ('N',#$D2,'n'),
  ('M',#$DC,'m'), (',',#$C1,'<'), ('.',#$DE,'>'), ('/','.',','), (' ',' ',' '),
  ('|','\','\'));
var
NumKey // Номер клавиши
       :  integer;
begin
if KeyIn = VK_RETURN then        //Отработка ETX
 begin Result:='c'; Exit end;
case KeyIn of
$C0: KeyIn:=ord('`');
$BD: KeyIn:=ord('-');
$BB: KeyIn:=ord('=');
$DB: KeyIn:=ord('[');
$DD: KeyIn:=ord(']');
$BA: KeyIn:=ord(';');
$DE: KeyIn:=ord('''');
$BC: KeyIn:=ord(',');
$BE: KeyIn:=ord('.');
$BF: KeyIn:=ord('/');
$DC: KeyIn:=ord('\');
$E2: KeyIn:=ord('|');
end; // case KeyIn
//
//if ((ssShift in Shift) = false) and (CaseKeyboard = 0) then
// begin Result:=chr(KeyIn); Exit end;
Result:=chr(0);
if (KeyIn in [$30..$39,$08]) or
 (chr(KeyIn) = '`') or (chr(KeyIn) = '-') or (chr(KeyIn) = '=') then
 for NumKey:=0 to Length(KeyToNVMZ1)-1 do
  if KeyToNVMZ1[NumKey,0] = chr(KeyIn) then
   begin
   Result:=KeyToNVMZ1[NumKey,0];
   if Shift = [ssShift] then
    case CaseKeyboard of
    0: Result:=KeyToNVMZ1[NumKey,1];
    1: Result:=KeyToNVMZ1[NumKey,2];
    end; // case CaseKeyboard
   if Shift = [ssAlt] then
    case CaseKeyboard of
    0: Result:=KeyToNVMZ1[NumKey,2];
    1: Result:=KeyToNVMZ1[NumKey,1];
    end; // case CaseKeyboard
   Exit;
   end;
if (KeyIn in [$41..$5A]) or
   (chr(KeyIn) = '[')  or (chr(KeyIn) = ']') or (chr(KeyIn) = ';') or
   (chr(KeyIn) = '''') or (chr(KeyIn) = ',') or (chr(KeyIn) = '.') or
   (chr(KeyIn) = '/')  or (chr(KeyIn) = ' ') or (chr(KeyIn) = '\') or
   (chr(KeyIn) = '|')  then
 for NumKey:=0 to Length(KeyToNVMZ24)-1 do
  if KeyToNVMZ24[NumKey,0] = chr(KeyIn) then
   begin
   case CaseKeyboard of
   0: Result:=KeyToNVMZ24[NumKey,0];
//
//      1: Result:=KeyToNVMZ24[NumKey,2];
//
   1: Result:=KeyToNVMZ24[NumKey,1]; //Штатно
   end; // case CaseKeyboard
   if Shift = [ssShift] then
    case CaseKeyboard of
    0: Result:=KeyToNVMZ24[NumKey,1];
    1: Result:=KeyToNVMZ24[NumKey,0];
    end; // case CaseKeyboard
   if Shift = [ssAlt] then
    case CaseKeyboard of
    0: Result:=KeyToNVMZ24[NumKey,1];
    1: Result:=KeyToNVMZ24[NumKey,2];
    end; // case CaseKeyboard
   if (Shift = [ssCtrl]) and (KeyIn in [$41..$5A]) then
    Result:=KeyToNVMZ24[NumKey,2];
//
// ДЛЯ ПРАВИЛЬНОГО ОТОБРАЖЕНИЯ "<" И ">"
//FormDebug.Write(KeyIn);
//if (CaseKeyboard=1) and (Shift = [ssAlt]) and (chr(KeyIn)='Б') then
// if (Shift = [ssAlt]) and (chr(KeyIn)='Б') then
//  StrScreen:='МЕНЬШЕ';
//Result:='<';
//
//
   Exit;
   end;
end;
//
// Перепись копии экрана в Memo
// ============================
//Проблема мерцания связана с ошибками в процедуре прокрутки
//экрана Мемо.
//
procedure TFormMain.StrScreenToMemo
 (EndUpdate : boolean);
var
j:integer;
Str     // Строка копии экрана
        :  string;
NumSym, // Номер символа
NumStr, // Число строк
Count   // Счетчик строк
        :  integer;
NumFirstLine // Номер первой видимой строки
             :  integer;
//
//L:tStringList;
//
begin
Memo.Lines.BeginUpdate;
{$IFDEF MSWINDOWS}LockWindowUpdate(Memo.Handle);{$ENDIF}  // Устан. блокир. обнов. экрана. (Не нужно)
if Style = Accurate then
 begin
 NumStr:=0;
 NumSym:=Pos(CR+LF, StrScreen);
 while NumSym <> 0 do
  begin
  NumStr:=NumStr+1;
  NumSym:=AnsiPosNum(CR+LF, StrScreen, NumSym+2);
  end;
 if NumStr > NumStrScr then
  case ButtonROLL.Tag of
  0: // No ROLL
   begin
   NumSym:=Pos(CR+LF, StrScreen);
   for Count:=1 to NumStr-(NumStr mod NumStrScr)-1 do
    NumSym:=AnsiPosNum(CR+LF, StrScreen, NumSym+2);
   Str:=Copy(StrScreen, NumSym+2, Length(StrScreen));
   Delete(StrScreen, NumSym+2, Length(StrScreen));
   PosScr:=NumSym+2;
   NumSym:=Pos(CR+LF, StrScreen);
   for Count:=1 to (NumStr div NumStrScr)*NumStrScr-(NumStr mod NumStrScr) do
    NumSym:=AnsiPosNum(CR+LF, StrScreen, NumSym+2);
   StrScreen:=Str+Copy(StrScreen, NumSym+2, Length(StrScreen));
   end;
  1: // ROLL
   for Count:=1 to NumStr-NumStrScr do
    begin
    NumSym:=Pos(CR+LF, StrScreen);
    Delete(StrScreen, 1, NumSym+2);
    if (PosScr-NumSym-2) >=0 then
     PosScr:=PosScr-NumSym-2;
    end;
  end; // case ButtonRool.Tag
// StrScreen:=Str;
//
// Собственно перепись в Мемо
//
//L:=tStringList.Create;
for j:=1 to Length(StrScreen)-1 do
 if StrScreen[j]='#' then
  FormDebug.Write('G6:'+IntToStr(j));
 end;
//
Str:=StrScreen;
//
//Упрятывание управляющих символов. Здесь должна быть отработка Ctrl

if (TypeShowCtrl in [0,2]) or (ButtonBLINK.Tag = 0) then
 for NumSym:=1 to Length(Str) do
  if Str[NumSym] in ['a'..'z'] then Str[NumSym]:=' ';
//

//ScrollCaret(Memo);      //  ТЕСТ
//    ActiveControl:=Memo;  //    ТЕСТ

Memo.Text:=Str;
//Memo.Text:=Memo.Lines.Add(Str);
//L.Add(Str);
//L.SaveToFile('test.txt');
//L.Free;
//Memo.Lines.LoadFromFile('test.txt');
//
Memo.SelStart:=PosScr;

for j:=1 to Length(StrScreen)-1 do
 if StrScreen[j]='#' then
  FormDebug.Write('G7:'+IntToStr(j));
// end;


{if Memo.Text <> Str then
 begin
 FormDebug.Write('ПИЗДЕЦ!!!');
 StrScreen:='СЛУЧИЛСЯ ПИЗДЕЦ. НАДО РАЗБИРАТЬСЯ!';
 PosScr:=0;
 Memo.Text:=StrScreen;
 Memo.SelStart:=PosScr;
 end;}
//SendMessage(Memo.Handle,EM_LINESCROLL,0,-Memo.Lines.Count); // Для прокрутки в нач.
{$IFDEF MSWINDOWS}LockWindowUpdate(0);{$ENDIF}  // Отмена блокировки обнов. экрана
Memo.Lines.EndUpdate;
end;

//
// Установка кнопки
// ================
procedure TFormMain.SetButton
 (Key // Нажатая клавиша
      :  Word);
begin
if Key=VK_F1  then ActiveControl:=ButtonOFF;
if Key=VK_F2  then ActiveControl:=ButtonON;
if Key=VK_F3  then ActiveControl:=ButtonPrint;
if Key=VK_F4  then ActiveControl:=ButtonSend;
if Key=VK_F5  then ActiveControl:=ButtonMPON;
if Key=VK_F6  then ActiveControl:=ButtonROLL;
if Key=VK_F7  then ActiveControl:=ButtonBLINK;
if Key=VK_F8  then ActiveControl:=ButtonERASE;
if Key=VK_F9  then ActiveControl:=ButtonDL;
if Key=VK_F10 then ActiveControl:=ButtonIL;
if Key=VK_F11 then ActiveControl:=ButtonDC;
if Key=VK_F12 then ActiveControl:=ButtonIC;
if Key=VK_ESCAPE then ActiveControl:=Memo;
ClickButton(Key);
end;
//
// Нажатие кнопки
// ==============
procedure TFormMain.ClickButton
 (Key // Нажатая клавиша
      :  Word);
begin
if Key=VK_F1  then ButtonOFFClick(Self);
if Key=VK_F2  then ButtonONClick(Self);
if Key=VK_F3  then ButtonPrintClick(Self);
if Key=VK_F4  then ButtonSendClick(Self);
if Key=VK_F5  then ButtonMPONClick(Self);
if Key=VK_F6  then ButtonROLLClick(Self);
if Key=VK_F7  then ButtonBLINKClick(Self);
if Key=VK_F8  then ButtonERASEClick(Self);
if Key=VK_F9  then ButtonDLClick(Self);
if Key=VK_F10 then ButtonILClick(Self);
if Key=VK_F11 then ButtonDCClick(Self);
if Key=VK_F12 then ButtonICClick(Self);
end;
//
// Создание формы
// ==============
procedure TFormMain.FormCreate(Sender: TObject);
var
FileSave // Файл параметров
         :  TIniFile;
CountKey //
         :  integer;
begin
for CountKey:=0 to ParamCount do
 begin
// Memo.Lines.Add(ParamStr(CountKey));
 end;
NameFileSave:=ExtractFilePath(ParamStr(0))+NameFileSave;
Memo.Lines.Add(ParamStr(0));
FileSave:=TIniFile.Create(NameFileSave);
Top:=FileSave.ReadInteger('Main', 'Top', 100);
Left:=FileSave.ReadInteger('Main', 'Left', 80);
Height:=FileSave.ReadInteger('Main', 'Height', 553);
Width:=FileSave.ReadInteger('Main', 'Width', 834);
Caption:=Caption+' '+Version;
TimerWork:=true;
MMTimer.Checked:=true;
//PMTimer.Checked:=true;
//
ReadPrmServer;
ReadPrmScreen;
//
case Keyboard of
0: // WINDOWS
 SetUnknownKeyboard;
1: // НВМЗ
 begin
// if (GetKeyState(VK_CAPITAL) and 1) = 0
 if EditKey.Tag = 0
  then SetLatKeyboard
  else SetRusKeyboard
 end;
end; // case Keyboard
//
T:=0;
ShowCtrl:=false;
ClipBoard:=TClipboard.Create;
ButtonOFFClick(Self);
//
Memo.Height:=0;
end;
//
// Активизация формы
// =================
procedure TFormMain.FormActivate(Sender: TObject);
begin

if CheckPassword = true then
 begin
 FormEntry.ShowModal;
 if FormEntry.Attempt <> 0 then Close;
 end;
end;
//
// Закрытие формы
// ==============
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
FileSave // Файл параметров
         :  TIniFile;
begin
FileSave:=TIniFile.Create(NameFileSave);
FileSave.WriteInteger('Main', 'Top', Top);
FileSave.WriteInteger('Main', 'Left', Left);
FileSave.WriteInteger('Main', 'Height', Height);
FileSave.WriteInteger('Main', 'Width', Width);
WritePrmServer;
if SavePrmScr = true then
 WritePrmScreen;
end;
//
// Нажатие кнопки мыщи
// ===================
//procedure TFormMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
//  Shift: TShiftState; X, Y: Integer);
//begin
//
//end;
//
// Нажатие клавиши клавиатуры
// ==========================
//procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word;
// Shift: TShiftState);
//begin
//Memo.Height:=Image.Height;
//Image.Height:=0;
//end;



//
// Прокрутка вниз
// ==============
procedure TFormMain.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
P // Точка на Memo
  :  TPoint;
begin
if Shift = [] then
 begin ScrollLineDown(Memo); Exit end;
if Shift = [ssCtrl] then
 begin
 P.Y:=Memo.CaretPos.Y;
 P.X:=Memo.CaretPos.X;
 FormDebug.Write('MouseWheelDown=>'+IntToStr(P.Y));
 P.Y:=P.Y+1;
 FormDebug.Write('MouseWheelDown=>'+IntToStr(P.Y));
 Memo.CaretPos:=P;
 FormDebug.Write('MouseWheelDown=>'+IntToStr(Memo.CaretPos.Y));
 end;
end;
//
// Прокрутка вверх
// ===============
procedure TFormMain.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
P // Точка на Memo
  :  TPoint;
begin
if Shift = [] then
 begin ScrollLineUP(Memo); Exit end;
if Shift = [ssCtrl] then
 begin
 P.Y:=Memo.CaretPos.Y;
 P.X:=Memo.CaretPos.X;
 FormDebug.Write('MouseWheelDown=>'+IntToStr(P.Y));
 P.Y:=P.Y-1;
 FormDebug.Write('MouseWheelDown=>'+IntToStr(P.Y));
 Memo.CaretPos:=P;
 FormDebug.Write('MouseWheelDown=>'+IntToStr(Memo.CaretPos.Y));
 end;
end;
//
// Событие "Подключение к серверу"
// ===============================
procedure TFormMain.IdTelnetConnected(Sender: TObject);
begin
//Memo.Lines.Add('Терминал подключен');
end;
//
// Пришло сообщение от сервера
// ===========================
procedure TFormMain.IdTelnetDataAvailable(Sender: TIdTelnet;
  const Buffer: TIdBytes);
var
StrASCII // Строка от сервера
         :  string;
NumSym,  // Номер символа
NumH     //
         :  integer;
begin
//FormDebug.Write('GET1:'+ByteArrayToHexString(Buffer));
if Mode = OFFLine then Exit;
SetString(StrASCII, PAnsiChar(Buffer), Length(Buffer));
//FormDebug.Write('GET2:'+StrASCIIToHexString(StrASCII));
//FormDebug.Write('GET3:'+StrASCII);
//exit;
//
StrASCII:=BESM6ToStr(StrASCII);
//if GraylingTest = true then
// GraylingStr:=GraylingStr+StrASCII;
//FormDebug.Write('GET4:'+StrASCII);
while (StrSend <> '') and (StrASCII <> '') do
// if StrASCII[1] = StrSend[1] then
  begin
  Delete(StrSend, 1, 1);
  Delete(StrASCII, 1, 1);
  end;
if StrSend <> '' then Exit;
NumH:=0;
NumSym:=Pos('h', StrASCII);
while NumSym <> 0 do
 begin
 Delete(StrASCII, NumSym, 1);
 NumH:=NumH+1;
 NumSym:=AnsiPosNum('h', StrASCII, NumSym+1);
 end;
//StrScreen:=StrScreen+StrASCII;
//StrScreen:='';
Delete(StrScreen, PosScr+1, Length(StrASCII));
Insert(StrASCII, StrScreen, PosScr+1);
PosScr:=PosScr+Length(StrASCII)-NumH;
//PosScr:=PosScr+Length(StrASCII);
//
// ТЕСТ ХАРИУС
if GraylingTest = true then
 GraylingStr:=GraylingStr+StrASCII;
StrScreenToMemo(false);
//Memo.Perform(EM_SCROLLCARET, 0, 0);
ScrollCaret(Memo);
//Memo.SelStart:=Memo.SelStart+Length(StrASCII);
ActiveControl:=Memo;
end;
//
// Нажатие кнопки мыщи(Image)
// ===========================
procedure TFormMain.ImageClick(Sender: TObject);
begin
//Memo.Height:=HeightTmp;
Memo.Height:=Image.Height;
Image.Height:=0;
end;
//
// Нажатие кнопки мыщи (Memo)
// ==========================
procedure TFormMain.MemoMouseDown(Sender: TObject; Button: TMouseButton;
 Shift: TShiftState; X, Y: Integer);
var
SelStart //
         : integer;
begin
FormDebug.Write('MD:'+IntToStr(PosScr)+' '+IntToStr(Memo.SelStart));
if Button <> mbLeft then Exit;
if Shift = [ssCtrl]
 then
  begin
  SelStart:=Memo.SelStart;
  Memo.SelStart:=PosScr;
  Memo.SelLength:=SelStart-PosScr;
  end
 else
  begin
  PosScr:=Memo.SelStart;
  Memo.SelLength:=0;
  end;
//++Memo.Perform(EM_SCROLLCARET, 0, 0);
end;
//
// Нажатие клавиши клавиатуры (Memo)
// =================================
procedure TFormMain.MemoKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
var
KeySend, // Символ для передачи на БЭСМ-6
KeyMemo  // Символ для записи в Memo
         :  char;
begin
//SendMessage(Memo.Handle,EM_LINESCROLL,0,-Memo.Lines.Count); // Здесь срабатывает
// только при нажатии кнопки OFF
if Key in [VK_SHIFT, VK_CONTROL, VK_MENU] then Exit;
if Key in [VK_PRIOR..VK_DOWN,	VK_CAPITAL,	VK_NUMLOCK, VK_SCROLL] then Exit;
if Key in [VK_NUMPAD0..VK_DIVIDE] then Exit;
if (Mode = ONLine) and (IdTelnet.Connected = true) and (Key = VK_DELETE) then
 begin IdTelnet.SendString(chr($7F)); Exit end;
//if (Mode = ONLine) and (IdTelnet.Connected = true) and (Key = VK_SPACE) then
// begin IdTelnet.SendString(chr($20)); Exit end;
//if (Mode = OFFLine) then
//begin
//SendMessage(Memo.Handle,EM_LINESCROLL,0,-Memo.Lines.Count); // Тест
//ScrollCaret(Memo);
//    ActiveControl:=Memo;
  if (Mode = OFFLine) and (Key in [VK_BACK, VK_DELETE{, VK_SPACE}]) then
 begin
//LineScroll(Memo, PosScr); // Тест
//SendMessage(Memo.Handle,EM_LINESCROLL,0,-Memo.Lines.Count); // Тест
 case Key of
 VK_BACK:   // Backspace
  if PosScr <> 0 then
   begin
   Delete(StrScreen, PosScr+1, 1);
   PosScr:=PosScr-1;
   end;
 VK_DELETE: // Delete
  Delete(StrScreen, PosScr+1, 1);
// VK_SPACE:  // Пробел
//  begin
//  Insert(' ', StrScreen, PosScr+1);
//  PosScr:=PosScr+1;
//  end;
 end; // case Key
 StrScreenToMemo(true);
 Exit;
 end;
  if Key in [VK_F1..VK_F12, VK_ESCAPE] then
 begin SetButton(Key); Exit end;
  if (Key = VK_INSERT) and (Shift = []) then
 begin
 case EditMode.Tag of
 0: // Вставить --> Заменить
  SetOwerwriteKeyboard;
 1: // Заменить --> Вставить
  SetInsertKeyboard;
 end; // case EditMode.Tag
 Exit
 end;
  if Keyboard = 0 then Exit;
  if (Key = VK_INSERT) and (Shift = [ssCtrl]) then
 begin
 case EditKey.Tag of
 0: // Латинская --> Русская
  SetRusKeyboard;
 1: // Русская --> Латинская
  SetLatKeyboard;
 end; // case EditKey.Tag
 Exit
 end;
//end; // тестовая
 //
FormDebug.Write('KDown1=>'+chr(Key)+'<');
//
KeyMemo:=KeyToSymNVMZ(Key, EditKey.Tag, Shift);
FormDebug.Write('KDown2=['+IntToHex(Key, 2)+'] '+ShiftStateToString(Shift));
FormDebug.Write('KDown3=>'+KeyMemo+'<>'+chr(Key)+'<');
if ord(KeyMemo) = 0 then Exit;
//
if (Mode = ONLine) and (IdTelnet.Connected) = true then
 begin
 KeySend:=CharToBESM6(KeyMemo);
 IdTelnet.SendString(KeySend);
 Exit;
 end;
case EditMode.Tag of
0: // Вставка
 Insert(KeyMemo, StrScreen, Memo.SelStart+1);
1: // Замена
 Replace(KeyMemo, StrScreen, PosScr);
end; //case EditMode.Tag
PosScr:=PosScr+1;
StrScreenToMemo(false);
end;
//
procedure TFormMain.MemoKeyPress(Sender: TObject; var Key: Char);
var
KeySend,     // Символ для передачи на БЭСМ-6
KeyOut       // Символ для записи в Memo
             :  char;
Shift        // Состояние клавиш
             :  TShiftState;
//NumFirstLine // Номер первой видимой строки
//             :  integer;
begin
if Keyboard = 1 then Exit;
FormDebug.Write('KPress1= ['+Key+'] '+Format('%.2X',[integer(Key)])+ShiftStateToString(Shift));
KeyOut:=KeyToSym(ord(Key));
FormDebug.Write('KPress2= ['+KeyOut+'] '+Format('%.2X',[integer(KeyOut)]));
//
Key:=KeyOut;
ScrollCaret(Memo);
    ActiveControl:=Memo;  // ТЕСТ
    if (Mode = ONLine) and (IdTelnet.Connected) = true then
 begin
 KeySend:=CharToBESM6(KeyOut);
 IdTelnet.SendString(KeySend);
 FormDebug.Write('PUT1:'+Key);
 // IdTelnet.SendCh(Pchar(Key));
 Exit;
 end;
case EditMode.Tag of
0: // Вставка
 Insert(KeyOut, StrScreen, Memo.SelStart+1);
1: // Замена
 Replace(KeyOut, StrScreen, PosScr);
end; //case EditMode.Tag
PosScr:=PosScr+1;
StrScreenToMemo(false);
end;
//
procedure TFormMain.MemoKeyUp(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
FormDebug.Write('KU=['+IntToHex(Key, 2)+'] '+ShiftStateToString(Shift));
FormDebug.Write('KU POS='+IntToStr(Memo.SelStart));
//
case Key of
 VK_DELETE:  // Delete
  begin
  end;
 VK_RETURN: // Return
  begin
  end;
 VK_END,   // End
 VK_HOME,  // Home
 VK_LEFT,  // Стелка влево
 VK_UP,    // Стелка вверх
 VK_RIGHT, // Стелка вправо
 VK_DOWN:  // Стелка вниз
  PosScr:=Memo.SelStart;
end; // case Key
end;
//
// Таймер
// ======
procedure TFormMain.TimerTimer(Sender: TObject);
var
Str       //
          :  string;
i         //
          :  integer;
SelStart, //
SelLength //
          :  integer;
begin
WriteEditPos;
if TimerWork = false then Exit;
//
GraylingTime:=GraylingTime+1;
//
//if IdTelnet.Connected = true then
// IdTelnet.SendString(chr(0));



//++TimeUpdate:=TimeUpdate+1;
//++
{if TimeUpdate > 5 then
 begin
//++ Memo.Lines.EndUpdate;
//++ TimeUpdate:=0;
 end;
}
//
SelStart:=Memo.SelStart;
SelLength:=Memo.SelLength;
//
if (ButtonBlink.Tag = 0) or (TypeShowCtrl <> 0) then Exit;
if PosScr <> SelStart then SelLength:=0;
//
if T = 1000 then T:=0 else T:=T+1;
if (T mod TimeCtrlBlink) = 0 then
 begin
 Str:=StrScreen;
 if (ShowCtrl = true) and (ButtonBlink.Tag = 1) then
  begin
  for i:=1 to Length(StrScreen) do
   if StrScreen[i] in ['a'..'z'] then
    Str[i]:=UpCase(StrScreen[i]);
  ShowCtrl:=false;
  end
 else
  begin
  for i:=1 to Length(StrScreen) do
   if StrScreen[i] in ['a'..'z'] then
    Str[i]:=' ';
   ShowCtrl:=true;
  end;
// CaretPos:=Memo.CaretPos;
// SelStart:=Memo.SelStart;
// SelLength:=Memo.SelLength;
//++ Memo.LinesBeginUpdate;
 Memo.Text:=Str;
//++ Memo.Lines.EndUpdate;
 Memo.SelStart:=PosScr;
 Memo.SelLength:=SelLength;
 end;
end;
//
// Главное меню - "Управление - Подключить"
// ========================================
procedure TFormMain.MMConnectClick(Sender: TObject);
var
//NameFileSave    // Имя файла сохранения параметров
//                :  string;
{$IFDEF MSWINDOWS}
ResCreate       // Результат выполнения функций запуска процесса
                :  boolean;
ResWait         // Результат выполнения функций ожидания
                :  DWORD;
InfStartProcess // Информация о запускаемом процессе
                :  TStartupInfo;
InfProcess      // Информация о выполнении запущенного процесса
                :  TProcessInformation;
{$ENDIF}
Str:string;
begin
case TypeConnect of
0: // Telnet
 begin
 if (NameServer = '') or (Port = '') then
  begin
  Application.MessageBox('Не заданы параметры', 'Ошибка');
  Exit;
  end;
 IdTelnet.Host:=Address;
 IdTelnet.Port:=StrToInt(Port);
 if IdTelnet.Connected = true then
  begin
  Application.MessageBox('Подключение к серверу уже установлено', 'Ошибка');
  Exit;
  end;
 try
 IdTelnet.Connect;
 except
 Application.MessageBox('Подключение не удалось', 'Ошибка');
 Exit;
 end;
 end;
1: // SSH
 begin
{$IFDEF MSWINDOWS}
 FillChar(InfStartProcess,SizeOf(InfStartProcess),#0);
 InfStartProcess.cb:=SizeOf(InfStartProcess);
 InfStartProcess.dwFlags:=STARTF_USESHOWWINDOW;
 InfStartProcess.wShowWindow:=SW_SHOWNORMAL;

 Str:='plink.exe '+Address+ ' -hostkey '+SSHServerKey+
 ' -P '+Port+' -batch -i "'+NameServer+'".ppk'+
  ' -N -L 127.0.0.1:'+SSHLockPort+':127.0.0.1:'+SSHLockPort;

  Memo.Lines.Add(Str);
 ResCreate:=CreateProcess(nil,
 PChar(Str),
  nil, nil, false, CREATE_NEW_CONSOLE, nil,
  PChar(ExtractFilePath(ParamStr(0))),
  InfStartProcess, InfProcess);
 if ResCreate = false then
  begin
  Application.MessageBox('Ошибка запуска', 'Туннель SSH', MB_OK);
  Exit
  end;
{$ENDIF}
{$IFDEF LINUX}
 Str:='ssh -N'+
  ' -L 127.0.0.1:'+SSHLockPort+':127.0.0.1:'+SSHLockPort+
  ' -i "'+NameServer+'.ppk"'+
  ' -o StrictHostKeyChecking=accept-new'+
  ' -p '+Port+' '+Address;
 Memo.Lines.Add(Str);
 with TProcess.Create(nil) do
  begin
  CommandLine:=Str;
  Options:=[poNoConsole];
  Execute;
  Free;
  end;
{$ENDIF}
// repeat
//  Application.ProcessMessages;
//  ResWait:=WaitForSingleObject(InfProcess.hProcess, 20);
//  if ResWait = WAIT_FAILED then Break;
// until ResWait = WAIT_OBJECT_0;
//
 IdTelnet.Host:='127.0.0.1';
 IdTelnet.Port:=StrToInt(SSHLockPort);
 if IdTelnet.Connected = true then
  begin
  Application.MessageBox('Подключение к серверу уже установлено', 'Ошибка');
  Exit;
  end;
 try
 IdTelnet.Connect;
 except
 Application.MessageBox('Подключение не удалось', 'Ошибка');
 Exit;
 end;
 end;
end;
//
if SetRaw = true then
 begin
 IdTelnet.SendString(#$07+'set raw'+CR+LF+CR+LF);
 Sleep(1500);
 IdTelnet.SendString(StrToBESM6('НУСc'));
 end;
ButtonONClick(Self);
end;
//
// Функция закрытия вызванной программы
//
function KillTask(ExeFileName:String):integer;
{$IFDEF MSWINDOWS}
  const Process_Terminate=$0001;
  var ContinueLoop:BOOL;
      FSnapShotHandle:THandle;
      FProcessEntry32:TProcessEntry32;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
 result:=0;
 FSnapShotHandle:=CreateToolHelp32SnapShot(TH32CS_SnapProcess,0);
 FProcessEntry32.dwSize:=SizeOf(FProcessEntry32);
 continueLoop:=Process32First(FSnapShotHandle,FProcessEntry32);
 while integer(continueloop)<>0 do
  begin
   if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))= UpperCase(ExeFileName))
    or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))) then
     Result:=Integer(TerminateProcess(OpenProcess(Process_TERMINATE,bool(0),
      FProcessEntry32.th32ProcessID),0));
     ContinueLoop:=Process32Next(FSnapShotHandle,FProcessEntry32);
     end;
     CloseHandle(FSnapShotHandle);
{$ELSE}
 Result:=0; // SSH subprocess lifetime managed by the OS on Linux
{$ENDIF}
     end;
//
// Главное меню - "Управление - Отключить"
// =======================================
procedure TFormMain.MMDisconectClick(Sender: TObject);
begin
IdTelnet.Disconnect;
end;
//
// Главное меню - "Управление - Выход"
// ===================================
procedure TFormMain.MMExitClick(Sender: TObject);
begin
if Disconnect = true then
 IdTelnet.Disconnect;
 KillTask('plink.exe');
Close;
end;
//
// Главное меню - "Редактирование - Удалить"
// =========================================
procedure TFormMain.MMDeleteClick(Sender: TObject);
var
Str // Текст удаления
    :  string;
begin
Str:=Copy(Memo.Text, Memo.SelStart+1, Memo.SelLength);
Clipboard.AsText:=Str;
Delete(StrScreen, Memo.SelStart+1, Memo.SelLength);
StrScreenToMemo(false);
Memo.SelLength:=0;
end;
//
// Главное меню - "Редактирование - Копировать"
// ============================================
procedure TFormMain.MMCopyClick(Sender: TObject);
var
Str // Текст копирования
    :  string;
begin
Str:=Copy(Memo.Text, Memo.SelStart+1, Memo.SelLength);
Clipboard.AsText:=Str;
end;
//
// Главное меню - "Редактирование - Копировать(РУС)"
// =================================================
procedure TFormMain.MMCopyRusClick(Sender: TObject);
var
Str // Текст копирования
    :  string;
begin
Str:=StrToRus(Copy(Memo.Text, Memo.SelStart+1, Memo.SelLength));
Clipboard.AsText:=Str;
end;
//
// Главное меню - "Редактирование - Копировать(ЛАТ)"
// =================================================
procedure TFormMain.MMCopyLatClick(Sender: TObject);
var
Str // Текст копирования
    :  string;
begin
Str:=StrToLat(Copy(Memo.Text, Memo.SelStart+1, Memo.SelLength));
Clipboard.AsText:=Str;
end;
//
// Главное меню - "Редактирование - Копировать (с учетом Ctrl)"
// ============================================================
procedure TFormMain.MMCopyCtrlClick(Sender: TObject);
var
Str // Текст копирования
    :  string;
begin
Str:=Copy(StrScreen, Memo.SelStart+1, Memo.SelLength);
Clipboard.AsText:=Str;
end;
//
// Главное меню - "Редактирование - Вставить"
// ==========================================
procedure TFormMain.MMInsertClick(Sender: TObject);
var
Str    // Текст для вставки
       :  string;
begin
Str:=Clipboard.AsText;
Str:=AnsiUpperCase(Str);
Str:=AddCtrlEJ(Str);
Insert(Str, StrScreen, Memo.SelStart+1);
StrScreenToMemo(false);
end;
//
// Главное меню - "Редактирование - Вставить (с учетом Ctrl)"
// ==========================================================
procedure TFormMain.MMInsertCtrlClick(Sender: TObject);
var
Str // Текст для вставки
    :  string;
begin
Str:=Clipboard.AsText;
Str:=AddCtrlEJ(Str);
Insert(Str, StrScreen, Memo.SelStart+1);
StrScreenToMemo(false);
end;
//
// Главное меню - "Редактирование - Преобразовать (РУС)"
// =====================================================
//procedure TFormMain.MMConvertRusClick(Sender: TObject);
//begin
//Memo.Text:=StrConvert(StrToRus(Memo.Text));
//end;
//
// Главное меню - "Редактирование - Преобразовать (ЛАТ)"
// =====================================================
//procedure TFormMain.MMConvertLatClick(Sender: TObject);
//begin
//Memo.Text:=StrConvert(StrToLat(Memo.Text));
//end;
//
// Главное меню - "Редактирование - Редактор"
// ==========================================
procedure TFormMain.MMCallEditClick(Sender: TObject);
var
{$IFDEF MSWINDOWS}
ResCreate       // Результат выполнения функций запуска процесса
                :  boolean;
ResWait         // Результат выполнения функций ожидания
                :  DWORD;
InfStartProcess // Информация о запускаемом процессе
                :  TStartupInfo;
InfProcess      // Информация о выполнении запущенного процесса
                :  TProcessInformation;
HandleStdOut,   // Дескриптор стандартного потока вывода
HandleStdErr,   // Дескриптор стандартного потока ошибок
HandleStdOutTmp,// Копия дескриптора стандартного потока вывода
HandleStdErrTmp // Копия дескриптор стандартного потока ошибок
                :  THandle;
{$ENDIF}
FileIn,         // Входной файл
FileOut         // Выходной файл
                :  TextFile;
Str,            //
StrOut          //
                :  string;
begin
//++Memo.Lines.Add(ExtractFilePath(ParamStr(0)));
//exit;
//++HandleStdOut:=FileOpen(ExtractFilePath(ParamStr(0))+NameStdOut,
//++ fmOpenReadWrite+fmShareDenyNone);
AssignFile(FileIn, ExtractFilePath(ParamStr(0))+NameStdIn);
Rewrite(FileIn);
Str:=Copy(Memo.Text, Memo.SelStart+1, Memo.SelLength);
Writeln(FileIn, Str);
CloseFile(FileIn);
//
{$IFDEF MSWINDOWS}
FillChar(InfStartProcess,SizeOf(InfStartProcess),#0);
InfStartProcess.cb:=SizeOf(InfStartProcess);
InfStartProcess.dwFlags:=STARTF_USESHOWWINDOW;
InfStartProcess.wShowWindow:=SW_SHOWNORMAL;
ResCreate:=CreateProcess(nil,
 PChar(Edit+' '+
 ExtractFilePath(ParamStr(0))+NameStdIn+' '+ExtractFilePath(ParamStr(0))+NameStdOut),
 nil, nil, false, CREATE_NEW_CONSOLE, nil,
 PChar(ExtractFilePath(ParamStr(0))),
 InfStartProcess, InfProcess);
if ResCreate = false then
 begin
 Application.MessageBox('Ошибка запуска', 'Редактор', MB_OK);
 Exit;
 end;
repeat
 Application.ProcessMessages;
 ResWait:=WaitForSingleObject(InfProcess.hProcess, 20);
 if ResWait = WAIT_FAILED then Break;
until ResWait = WAIT_OBJECT_0;
{$ENDIF}
{$IFDEF LINUX}
with TProcess.Create(nil) do
 begin
 CommandLine:=Edit+' '+
  ExtractFilePath(ParamStr(0))+NameStdIn+' '+ExtractFilePath(ParamStr(0))+NameStdOut;
 Options:=[poWaitOnExit];
 Execute;
 Free;
 end;
{$ENDIF}
//FileClose(HandleStdOut);
//FileClose(HandleStdErr);
// ResCreate:=TerminateProcess(InfProcess.hProcess, 0);
//++ CloseHandle(HandleStdOut);
// CloseHandle(HandleStdErr);
// CloseHandle(HandleStdInWrite);
// CloseHandle(InfProcess.hProcess);
//Memo.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+NameStdOut);
AssignFile(FileOut, ExtractFilePath(ParamStr(0))+NameStdOut);
Reset(FileOut);
//Copy(Memo.Text, Memo.SelStart+1, Memo.SelLength);
Str:='';
while Eof(FileOut) = false do
 begin
 ReadLn(FileOut, StrOut);
 Str:=Str+StrOut+CR+LF;
 end;
Delete(Str, Length(Str)-1, 2);
CloseFile(FileOut);
Delete(StrScreen, Memo.SelStart+1, Memo.SelLength);
Insert(Str, StrScreen, Memo.SelStart+1);
StrScreenToMemo(false);
end;
//
// Главное меню - "Редактирование - Искать"
// ========================================
procedure TFormMain.MMSearchClick(Sender: TObject);
begin
FormSearch.ShowModal;
Memo.SelStart:=1;
Memo.SelLength:=10;
end;
//
// Главное меню - "Редактирование - Печать экрана"
// ===============================================
procedure TFormMain.MMPrintClick(Sender: TObject);
{$IFDEF MSWINDOWS}
var
ToPrn //
      :  TextFile;
begin
Printer.Canvas.Font:=Memo.Font;
//PrintDialog.Options:=[poPrintToFile];
if PrintDialog.Execute = false then Exit;
AssignPrn(ToPrn);
Rewrite(ToPrn);
Writeln(ToPrn, StrScreen);
CloseFile(ToPrn);
{$ELSE}
begin
{$ENDIF}
end;
//
// Главное меню - "Параметры - Сервер"
// ===================================
procedure TFormMain.MMServerClick(Sender: TObject);
begin
FormSettingsServer.NameServer:=NameServer;
FormSettingsServer.TypeConnect:=TypeConnect;
FormSettingsServer.Address:=Address;
FormSettingsServer.Port:=Port;
FormSettingsServer.SSHServerKey:=SSHServerKey;
FormSettingsServer.SSHLockPort:=SSHLockPort;
FormSettingsServer.Disconnect:=Disconnect;
FormSettingsServer.SetRaw:=SetRaw;
FormSettingsServer.ShowModal;
if FormSettingsServer.ModalResult = mrCancel then Exit;
NameServer:=FormSettingsServer.NameServer;
TypeConnect:=FormSettingsServer.TypeConnect;
Address:=FormSettingsServer.Address;
Port:=FormSettingsServer.Port;
SSHServerKey:=FormSettingsServer.SSHServerKey;
SSHLockPort:=FormSettingsServer.SSHLockPort;
Disconnect:=FormSettingsServer.Disconnect;
SetRaw:=FormSettingsServer.SetRaw;
end;
//
// Главное меню - "Параметры - Экран и клавиатура"
// ===============================================
procedure TFormMain.MMScreenClick(Sender: TObject);
begin
FormSettingsScreen.Style:=Style;
FormSettingsScreen.NumStrScreen:=NumStrScreen;
FormSettingsScreen.NumStrScr:=NumStrScr;
FormSettingsScreen.ClearScr:=ClearScr;
FormSettingsScreen.ColorScr:=Memo.Color;
FormSettingsScreen.FontScr:=Memo.Font;
FormSettingsScreen.ShowCtrl:=TypeShowCtrl;
FormSettingsScreen.TimeBlink:=TimeCtrlBlink;
FormSettingsScreen.Keyboard:=Keyboard;
FormSettingsScreen.AddCtrlE:=AddCtrlE;
FormSettingsScreen.AckERASE:=AckERASE;
FormSettingsScreen.Edit:=Edit;
FormSettingsScreen.StatusButton:=StatusButton;
FormSettingsScreen.SavePrmScr:=SavePrmScr;
FormSettingsScreen.CheckPassword:=CheckPassword;
FormSettingsScreen.ShowModal;
if FormSettingsScreen.ModalResult = mrCancel then Exit;
Style:=FormSettingsScreen.Style;
NumStrScreen:=FormSettingsScreen.NumStrScreen;
NumStrScr:=FormSettingsScreen.NumStrScr;
ClearScr:=FormSettingsScreen.ClearScr;
Memo.Color:=FormSettingsScreen.ColorScr;
Memo.Font:=FormSettingsScreen.FontScr;
TypeShowCtrl:=FormSettingsScreen.ShowCtrl;
TimeCtrlBlink:=FormSettingsScreen.TimeBlink;
Keyboard:=FormSettingsScreen.Keyboard;
case Keyboard of
0: // WINDOWS
 SetUnknownKeyboard;
1: // НВМЗ
 SetRusKeyboard;
end; // case Keyboard
AddCtrlE:=FormSettingsScreen.AddCtrlE;
AckERASE:=FormSettingsScreen.AckERASE;
Edit:=FormSettingsScreen.Edit;
StatusButton:=FormSettingsScreen.StatusButton;
SavePrmScr:=FormSettingsScreen.SavePrmScr;
CheckPassword:=FormSettingsScreen.CheckPassword;
end;
//
// Главное меню - "Параметры - Сохранить"
// ======================================
procedure TFormMain.MMSavePrmClick(Sender: TObject);
begin
WritePrmServer;
WritePrmScreen;
end;
//
// Главное меню - "Параметры - Справка"
// ====================================
procedure TFormMain.MMHelpClick(Sender: TObject);
begin
FormHelp.ShowModal;
end;
//
// Главное меню - "Отладка-Таймер"
// ===============================
procedure TFormMain.MMTimerClick(Sender: TObject);
begin
if TimerWork = true
 then
  begin
  MMTimer.Checked:=false;
  TimerWork:=false;
  end
 else
  begin
  MMTimer.Checked:=true;
  TimerWork:=true;
  end
end;
//
// Главное меню - "Отладка-Не выводить отладочные сообщения"
// =========================================================
procedure TFormMain.MMNoOutputClick(Sender: TObject);
begin
if MMNoOutput.Checked = true
 then MMNoOutput.Checked:=false
 else MMNoOutput.Checked:=true;
end;
//
// Главное меню - "Отладка - Окно вывода"
// ======================================
procedure TFormMain.MMOutputClick(Sender: TObject);
begin
FormDebug.Show;
end;
//
// Главное меню - "Отладка - Копия экрана"
// =======================================
procedure TFormMain.MMScreenCopyClick(Sender: TObject);
begin
FormDebug.Write('Копия экрана');
FormDebug.Write(StrASCIIToHexString(StrScreen));
end;
//
// Главное меню - "Отладка - Экран (Memo)"
// =======================================
procedure TFormMain.MMScreenMemoClick(Sender: TObject);
begin
FormDebug.Write('Экран (Memo)');
FormDebug.Write(StrASCIIToHexString(Memo.Text));
end;
//
// Главное меню - "Отладка - Эмулятор БЭСМ-6 - SET UNICODE"
// ========================================================
procedure TFormMain.MMUNICODEClick(Sender: TObject);
begin
IdTelnet.SendString(#$07+'SET UNICODE'+CR+LF+CR+LF);
end;
//
// Главное меню - "Отладка - Эмулятор БЭСМ-6 - SET JCUKEN"
// =======================================================
procedure TFormMain.MMJCUKENClick(Sender: TObject);
begin
IdTelnet.SendString(#$07+'SET JCUKEN'+CR+LF+CR+LF);
end;
//
// Главное меню - "Отладка - Эмулятор БЭСМ-6 - SET QWERTY"
// =======================================================
procedure TFormMain.MMQWERTYClick(Sender: TObject);
begin
IdTelnet.SendString(#$07+'SET QWERTY'+CR+LF+CR+LF);
end;
//
// Главное меню - "Отладка - Эмулятор БЭСМ-6 - SET RAW"
// ====================================================
procedure TFormMain.MMRAWClick(Sender: TObject);
begin
IdTelnet.SendString(#$07+'SET RAW'+CR+LF+CR+LF);
end;
//
// Главное меню - "Отладка - Эмулятор БЭСМ-6 - SHOW"
// =================================================
procedure TFormMain.MMSHOWClick(Sender: TObject);
begin
IdTelnet.SendString(#$07+'SHOW'+CR+LF+CR+LF);
end;
//
// Главное меню - "Отладка - Разметка экрана"
// ============================================
procedure TFormMain.MMLayoutClick(Sender: TObject);
begin
StrScreen:=
'12345678901234567890123456789012345678901234567890123456789012345678901234567890'+CR+LF+
'         1         2         3         4         5         6         7         8'+CR+LF+
' 3'+CR+LF+
' 4'+CR+LF+
' 5'+CR+LF+
' 6'+CR+LF+
' 7'+CR+LF+
' 8'+CR+LF+
' 9'+CR+LF+
'10'+CR+LF+
'11'+CR+LF+
'12'+CR+LF+
'13'+CR+LF+
'14'+CR+LF+
'15'+CR+LF+
'16'+CR+LF;
PosScr:=0;
StrScreenToMemo(false);
end;
//
// Главное меню - "Отладка - Ирбис"
// ================================
procedure TFormMain.MMIrbisClick(Sender: TObject);
begin
//HeightTmp:=Memo.Height;
Image.Height:=Memo.Height;
Memo.Height:=0;
end;
//
// Главное меню - "Отладка - Хариус - Подключить"
// ==============================================
procedure TFormMain.MMGrayling1ConnectClick(Sender: TObject);
begin
IdTelnet.Host:=Address;
IdTelnet.Port:=StrToInt(Port);
if IdTelnet.Connected = true then
 begin
 Application.MessageBox('Подключение к серверу уже установлено', 'Ошибка');
 Exit;
 end;
try
 IdTelnet.Connect;
except
 Application.MessageBox('Подключение не удалось', 'Ошибка');
 Exit;
end;
end;
//
// Главное меню - "Отладка - Хариус - Остановить"
// ==============================================
procedure TFormMain.MMGraylingStopClick(Sender: TObject);
begin
GraylingTest:=false;
end;
//
// Главное меню - "Отладка - Хариус - Тест 1"
// ==========================================
procedure TFormMain.MMGraylingTest1Click(Sender: TObject);
var i:integer;
begin
GraylingTest:=true;
i:=0;
while true do
 begin
// IdTelnet.SendString(IntToStr(i)+CR+LF);
// IdTelnet.SendString('QWERTYUIOP '+IntToStr(i)+{CR+LF+}#03);
 IdTelnet.SendString('QWERTYUIOP '+IntToStr(i)+{CR+LF+}' ');
 i:=i+1;
 Application.ProcessMessages;
 Sleep(1000);
 if GraylingTest = false then Exit;
 end;
end;
//
// Главное меню - "Отладка - Хариус - Тест 2"
// ==========================================
procedure TFormMain.MMGraylingTest2Click(Sender: TObject);
var i,j:integer;
StrOut //
       :  string;
begin
GraylingTest:=true;
GraylingTime:=0;
i:=0;
while true do
 begin
 GraylingStr:='';
 StrOut:='QWERTYUIOP '+Format('%.4d', [i])+{CR+LF+}' ';
 IdTelnet.SendString(StrOut);
 i:=i+1;
 GraylingTime:=0;
 while GraylingTime < 15 do
  begin
  Application.ProcessMessages;
  Sleep(100);
  end;
 if (Pos(GraylingStr, 'ОШИБ') <> 0) then
   if  (GraylingStr <> StrOut) then
  begin
  FormDebug.Write('G1:'+StrOut);
  FormDebug.Write('G2:'+GraylingStr);
  end;

  for j:=1 to Length(GraylingStr)-1 do
   if GraylingStr[j]='#' then
    FormDebug.Write('G3:'+IntToStr(j));
  for j:=1 to Length(StrScreen)-1 do
   if StrScreen[j]='#' then
    FormDebug.Write('G5:'+IntToStr(j));




 if GraylingTest = false then Exit;
 end;
end;
//
// Главное меню - "Отладка - Латинские буквы"
// ==========================================
procedure TFormMain.MMShowLatClick(Sender: TObject);
var
NumSym // Номер символа
       :  integer;
Str    // Строка
       :  string;
begin
Str:=Memo.Text;
for NumSym:=1 to Length(Str) do
Str[NumSym]:=DownCase(Str[NumSym]);
Memo.Text:=Str;
end;
//
// Главное меню - "Отладка - Атаки - DDoS"
// =======================================
procedure TFormMain.MMDDoSClick(Sender: TObject);
begin
//
end;
//
// Главное меню - "Отладка - Атаки - Блокировка терминалов КРАБа"
// ==============================================================
procedure TFormMain.MMBlockTermClick(Sender: TObject);
begin
//
end;
//
// Главное меню - "Отладка - Атаки - Пароль пользователя КРАБ"
// ===========================================================
procedure TFormMain.MMKeyUserClick(Sender: TObject);
begin
//
end;
//
// Главное меню - "Отладка - Отладка 1"
// ====================================
procedure TFormMain.MMDeb1Click(Sender: TObject);
var
Str1o,Str2o,Str3o,Str4o,
Str1n,Str2n,Str3n,Str4n: string;
begin
FormDebug.Write('Clipboard: '+Clipboard.AsText);
FormDebug.Write(' ');
//
Str1o:='`1234567890-=qwertyuiop[]\asdfghjkl;.zxcvbnm,./';
Str2o:='~!@#$%^&*()_+QWERTYUIOPASDFGHJKL:"ZXCVBNM<>?';
Str3o:='134567890-=йцукенгшщзхъ\фывапролджэячсмитьбю.';
Str4o:='Ё!"№;%:?*()_+ЙЦУКЕНГШЩЗХЪ/ФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,';
//
FormDebug.Write('Stro: '+Str1o);
Str1n:=StrToBESM6(Str1o); //, true);
FormDebug.Write('Strn: '+Str1n);
FormDebug.Write(' ');
//
FormDebug.Write('Str2o: '+Str2o);
Str2n:=StrToBESM6(Str2o);//,true);
FormDebug.Write('Str2n: '+Str2n);
FormDebug.Write(' ');
//
FormDebug.Write('Str3o: '+Str3o);
Str3n:=StrToBESM6(Str3o);//,true);
FormDebug.Write('Str3n: '+Str3n);
FormDebug.Write(' ');
//
FormDebug.Write('Str4o: '+Str4o);
Str4n:=StrToBESM6(Str4o);//,true);
FormDebug.Write('Str4n: '+Str4n);
FormDebug.Write(' ');
StrScreen:=Str1o+Str2o+Str3o+Str4o;
PosScr:=1;
StrScreenToMemo(false);
end;
//
// Главное меню - "Отладка - Отладка 2"
// ====================================
procedure TFormMain.MMDeb2Click(Sender: TObject);
begin
StrScreen:=
'12345678901234567890123456789012345678901234567890123456789012345678901234567890'+CR+LF+
'         1         2         3         4         5         6         7         8'+CR+LF+
'3333333333333333333331111111111111111'+CR+LF+
'3333333333333333333331111111111111111'+CR+LF+
'44a44444444444444444444444444444411111'+CR+LF+
'55b5555555555555555c5555555555551111111'+CR+LF+
'66666666666666666666e66666661111111111'+CR+LF+
'77777777d77777777777777777771111111111'+CR+LF+
'1111111111111111111111111111111111111'+CR+LF+
'1111111111111111111111111111111111111'+CR+LF+
'1111111111111111111111111111111111111'+CR+LF+
'1111111111111111111111111111111111111'+CR+LF+
'1111111111111111111111111111111111111'+CR+LF+
'1111111111111111111111111111111111111'+CR+LF+
'1111111111111111111111111111111111111'+CR+LF;
PosScr:=0;
StrScreenToMemo(false);
ButtonBlink.Font.Style:=[fsItalic];
ButtonBlink.Tag:=1;
end;
//
// Главное меню - "Отладка - Отладка 3"
// ====================================
procedure TFormMain.MMDeb3Click(Sender: TObject);
begin
StrScreen:=CR+LF+CR+LF+
'     xxxxxxx   xxxxx        xx  x        x     x   xxxxx '+CR+LF+
'        x     x     x      x x  x        x    x   x     x'+CR+LF+
'        x     x     x     x  x  xxxxxx   xxxx     x     x'+CR+LF+
'        x     x     x    x   x  x     x  x   x    x     x'+CR+LF+
'        x     x     x   x    x  x     x  x    x   x     x'+CR+LF+
'        x      xxxxx   x     x  xxxxxx   x     x   xxxxx '+CR+LF+
''+CR+LF+CR+LF+
'     xxxxxxx   xxxxx    xxxxx   xx   xx            xxxxx '+CR+LF+
'     x              x  x        x x x x           x      '+CR+LF+
'     x              x  x        x  x  x           x      '+CR+LF+
'     xxxxxx       xxx  x        x     x    xxx    xxxxxx '+CR+LF+
'     x     x        x  x        x     x           x     x'+CR+LF+
'     x     x        x  x        x     x           x     x'+CR+LF+
'     xxxxxx    xxxxx    xxxxx   x     x            xxxxx '+CR+LF;
PosScr:=0;
StrScreenToMemo(false);
ButtonBlink.Font.Style:=[fsItalic];
ButtonBlink.Tag:=1;
end;
//
// Главное меню - "Отладка - Отладка 4"
// ====================================
procedure TFormMain.MMDeb4Click(Sender: TObject);
begin
if (Mode = ONLine) and (IdTelnet.Connected) = true then
 IdTelnet.SendString(#$77#$63#$70#$70#$03);
//PosScr:=PosScr+1;
//Memo.Perform(EM_SCROLLCARET, 0, 0);
end;
//
// Контекстное меню - "Удалить"
// ============================
procedure TFormMain.PMDeleteClick(Sender: TObject);
begin
MMDeleteClick(Sender);
end;
//
// Контекстное меню - "Копировать"
// ===============================
procedure TFormMain.PMCopyClick(Sender: TObject);
begin
MMCopyClick(Sender);
end;
//
// Контекстное меню - "Копировать (РУС)"
// =====================================
procedure TFormMain.PMCopyRusClick(Sender: TObject);
begin
MMCopyRusClick(Sender);
end;
//
// Контекстное меню - "Копировать (ЛАТ)"
// =====================================
procedure TFormMain.PMCopyLatClick(Sender: TObject);
begin
MMCopyLatClick(Sender);
end;
//
// Контекстное меню - "Копировать (с учетом Ctrl)"
// ===============================================
procedure TFormMain.PMCopyCtrlClick(Sender: TObject);
begin
MMCopyCtrlClick(Sender);
end;
//
// Контекстное меню - "Вставть"
// ============================
procedure TFormMain.PMInsertClick(Sender: TObject);
begin
MMInsertClick(Sender);
end;
//
// Контекстное меню - "Вставть (с учетом Ctrl)"
// ============================================
procedure TFormMain.PMInsertCtrlClick(Sender: TObject);
begin
MMInsertCtrlClick(Sender);
end;
//
// Контекстное меню - "Печать экрана"
// ==================================
procedure TFormMain.PMPrintClick(Sender: TObject);
begin
MMPrintClick(Sender);
end;
//
// Контекстное меню - "Таймер"
// ===========================
procedure TFormMain.PMTimerClick(Sender: TObject);
begin
MMTimerClick(Sender);
end;
//
// Контекстное меню - "Вывод"
// ==========================
procedure TFormMain.PMOutputClick(Sender: TObject);
begin
MMOutputClick(Sender);
end;
//
// Кнопка "OFF"
// ============
procedure TFormMain.ButtonOFFClick(Sender: TObject);
begin
ButtonOFF.Font.Style:=[fsBold];
ButtonON.Font.Style:=[];
Mode:=OFFLine;
//Memo.ReadOnly:=false;
ActiveControl:=Memo;
end;
//
procedure TFormMain.ButtonOFFKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "ON"
// ===========
procedure TFormMain.ButtonONClick(Sender: TObject);
begin
ButtonOFF.Font.Style:=[];
ButtonON.Font.Style:=[fsBold];
Mode:=ONLine;
//Memo.ReadOnly:=true;
ActiveControl:=Memo;
end;
//
procedure TFormMain.ButtonONKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "Print"
// ==============
procedure TFormMain.ButtonPrintClick(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
if PrintDialog.Execute = false then Exit;
{$ENDIF}
end;
//
procedure TFormMain.ButtonPrintKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "Send"
// =============
procedure TFormMain.ButtonSendClick(Sender: TObject);
var
NumPos //
       :  integer;
begin
if IdTelnet.Connected = false then Exit;
case Style of
Accurate:
 begin
 Application.MessageBox('Не релизовано', 'NVMZ');
 end;
Modern:
 begin
//БУФЕР
Memo.Lines.BeginUpdate;
 if Memo.SelLength = 0
  then
   begin
   StrSend:=StrScreen;
   Delete(StrSend, 1, Memo.SelStart+1);
   NumPos:=Pos('c', StrSend);
   if NumPos <> 0 then
    Delete(StrSend, NumPos, Length(StrScreen));
   end
  else
   StrSend:=Copy(StrScreen, Memo.SelStart+1, Memo.SelLength);
//
 NumPos:=Pos(CR+LF, StrSend);
 while NumPos <> 0 do
  begin
  Delete(StrSend, NumPos, 2);
  NumPos:=Pos(CR+LF, StrSend);
  end;
//
 if LineSepIns = true then
  begin
  NumPos:=1;
  while NumPos < Length(StrSend) do
   begin
   if StrSend[NumPos] in ['a'..'z'] then
    begin
    Delete(StrSend, NumPos, 1);
    Continue;
    end;
   NumPos:=NumPos+1;
   end;
  NumPos:=LineSepNum;
  while NumPos < Length(StrSend) do
   begin
   Insert(LineSepSym, StrSend, NumPos+1);
//   NumPos:=NumPos+LineSepNum+1; //штатно
NumPos:=NumPos+LineSepNum;
   end;
  end;
 StrSend:=StrSend+'c';
//SendMessage(Memo.Handle,EM_LINESCROLL,0,Memo.Lines.Count); // Для прокрутки в кон.
//
 IdTelnet.SendString(StrToBESM6(StrSend));
//PosScr:=Memo.Lines.Count // ТЕСТ
 end;
end; // case Style
//
if ClearScr = true then
 begin
 StrScreen:='';
 PosScr:=0;
 end;
ButtonONClick(Self);
end;
//
procedure TFormMain.ButtonSendKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
Memo.Lines.EndUpdate;
end;

//
// Кнопка "MPON"
// =============
procedure TFormMain.ButtonMPONClick(Sender: TObject);
begin
case ButtonMPON.Tag of
0:
 begin
 ButtonMPON.Font.Style:=[fsItalic];
 ButtonMPON.Tag:=1;
 end;
1:
 begin
 ButtonMPON.Font.Style:=[];
 ButtonMPON.Tag:=0;
 end;
end; // case
end;
//
procedure TFormMain.ButtonMPONKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "ROLL"
// =============
procedure TFormMain.ButtonROLLClick(Sender: TObject);
//var
//  L: TStringList;
//  I: Integer;
//  S: String;
begin
case ButtonROLL.Tag of
0:
 begin
 ButtonROLL.Font.Style:=[fsBold];
 ButtonROLL.Tag:=1;
(*  i := 15 * (memo.Lines.Count div 15);
  while i > 14 do begin
    memo.Lines.Delete(pred(i));
    dec(i, 15);
  end;*) // не работает
(*  L := TStringList.Create;
  try
    for I := 0 to Memo.Lines.Count - 1 do
    begin
      S := Memo.Lines[I];
      if Pos('j', S) = 1  then
        L.Append(S);
    end;
    Memo.Lines.Assign(L);
  finally
    L.Free;
  end*)
end;
1:
 begin
 ButtonROLL.Font.Style:=[];
 ButtonROLL.Tag:=0;
 end;
end; // case ButtonROLL.Tag

end;
//
procedure TFormMain.ButtonROLLKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "Blink"
// ==============
procedure TFormMain.ButtonBLINKClick(Sender: TObject);
begin
case ButtonBlink.Tag of
0:
 begin
// ButtonBlink.Font.Style:=[fsItalic];
 ButtonBlink.Font.Style:=[fsBold];
  ButtonBlink.Tag:=1;
 StrScreenToMemo(false);
 end;
1:
 begin
 ButtonBlink.Font.Style:=[];
 ButtonBlink.Tag:=0;
 StrScreenToMemo(false);
 end;
end; // case ButtonBlink.Tag
ActiveControl:=Memo;
end;
//
procedure TFormMain.ButtonBLINKKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "Erase"
// ==============
procedure TFormMain.ButtonEraseClick(Sender: TObject);
var
ResExit // Ответ формы
        :  integer;
begin
//if Mode = ONLine then Exit;
if AckERASE = true then
 begin
 ResExit:=Application.MessageBox('Очистить экран?', 'Запрос', MB_YESNO+MB_DefButton2);
 if ResExit = Id_No then Exit;
 end;
StrScreen:='';
PosScr:=0;
StrScreenToMemo(false);
ActiveControl:=Memo;
end;
//
procedure TFormMain.ButtonEraseKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "DL"
// ===========
procedure TFormMain.ButtonDLClick(Sender: TObject);
var
//NumStr,   // Номер строки
CountStr, // Счетчик строк
NumPos,   // Номер позиции
NumEnd,    // Номер позиции
CurrentLine // Корректный Номер строки
          :  integer;
begin
if Mode = ONLine then Exit;
{$IFDEF MSWINDOWS}
CurrentLine:=SendMessage(memo.Handle,EM_LINEFROMCHAR, memo.SelStart, 0);
{$ELSE}
CurrentLine:=Memo.CaretPos.Y;
{$ENDIF}
CountStr:=0;
// CountStr:=Memo.Lines.Count;
for NumPos:=1 to Length(StrScreen) do
 begin
 if StrScreen[NumPos] = #13 then CountStr:=CountStr+1;
 if CountStr = CurrentLine then
  for NumEnd:=NumPos+1 to Length(StrScreen) do
   if StrScreen[NumEnd] = #13 then
    begin
    Delete(StrScreen, NumPos+2, NumEnd-NumPos);
    StrScreenToMemo(false);
//Memo.Perform(EM_SCROLLCARET, 0, 0);
ScrollCaret(Memo);
    ActiveControl:=Memo;
    Exit;
    end;
 end;
ActiveControl:=Memo;
end;
//
procedure TFormMain.ButtonDLKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "IL"
// ===========
procedure TFormMain.ButtonILClick(Sender: TObject);
var
//NumStr,   // Номер строки
CountStr, // Счетчик строк
NumPos,    // Номер позиции
CurrentLine // Корректный Номер строки
          :  integer;
begin
if Mode = ONLine then Exit;
{$IFDEF MSWINDOWS}
CurrentLine:=SendMessage(memo.Handle,EM_LINEFROMCHAR, memo.SelStart, 0);
{$ELSE}
CurrentLine:=Memo.CaretPos.Y;
{$ENDIF}
CountStr:=0;
for NumPos:=1 to Length(StrScreen) do
 begin
 if StrScreen[NumPos] = #13 then CountStr:=CountStr+1;
 if CountStr = CurrentLine then
  begin
  Insert(CR+LF, StrScreen, NumPos);
  StrScreenToMemo(false);
//++Memo.Perform(EM_SCROLLCARET, 0, 0);
  ActiveControl:=Memo;
  Exit;
  end;
 end;
ActiveControl:=Memo;
end;
//
procedure TFormMain.ButtonILKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "DC"
// ===========
procedure TFormMain.ButtonDCClick(Sender: TObject);
begin
if Mode = ONLine then Exit;
Delete(StrScreen, PosScr+1, 1);
StrScreenToMemo(false);
//++Memo.Perform(EM_SCROLLCARET, 0, 0);
ActiveControl:=Memo;
end;
//
procedure TFormMain.ButtonDCKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Кнопка "IC"
// ===========
procedure TFormMain.ButtonICClick(Sender: TObject);
begin
if Mode = ONLine then Exit;
Insert(' ', StrScreen, PosScr+1);
StrScreenToMemo(false);
ActiveControl:=Memo;
end;
//
procedure TFormMain.ButtonICKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Поле "Позиция"
// ==============
procedure TFormMain.EditPosKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
SetButton(Key);
end;
//
// Поле "Регистр клавиатуры"
// =========================
procedure TFormMain.EditKeyDblClick(Sender: TObject);
begin
case EditKey.Tag of
0: // Латинская --> Русская
 SetRusKeyboard;
1: // Русская --> Латинская
 SetLatKeyboard;
end; // case EditKey.Tag
end;
//
// Контекстное меню Key - "ЛАТ"
// ============================
procedure TFormMain.PMKeyLatClick(Sender: TObject);
begin
SetLatKeyboard;
end;
//
// Контекстное меню Key - "РУС"
// ============================
procedure TFormMain.PMKeyRusClick(Sender: TObject);
begin
SetRusKeyboard;
end;
//
// Поле "Режим клавиатуры"
// =======================
procedure TFormMain.EditModeDblClick(Sender: TObject);
begin
case EditMode.Tag of
0: // Вставить --> Заменить
 SetOwerwriteKeyboard;
1: // Заменить --> Вставить
 SetInsertKeyboard;
end; // case EditMode.Tag
end;
//
// Контекстное меню Mode - "ВСТ"
// =============================
procedure TFormMain.PMModeInsertClick(Sender: TObject);
begin
SetInsertKeyboard;
end;
//
// Контекстное меню Mode - "ЗАМ"
// =============================
procedure TFormMain.PMModeOverwriteClick(Sender: TObject);
begin
SetOwerwriteKeyboard;
end;
//
end.
