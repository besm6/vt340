//**********************************************************
//* Изделие Эмулятор VT-340                                *
//*--------------------------------------------------------*
//* Общие константы и переменные                           *
//*--------------------------------------------------------*
//* Автор:     Н.В.Макаров-Землянский                      *
//* Создание:  02.02.2017                                  *
//* Изменение: 22.05.2022                                  *
//**********************************************************
//
unit MainCV;
//
interface
//
type
TModeVT      // Режим работы
             = (OFFLine, ONLine);
TStyleVT     // Стиль отображения
             = (Accurate, Modern);
var
Version      // Версия
             :  string = '(Версия 02.1 от 30.05.2024)';
NameFileSave // Имя файла параметров
             :  string = 'Prm.ini';
NameStdIn    // Имя файла для входного потока
             :  string = 'StdIn.txt';
NameStdOut   // Имя файла для выходного потока
             :  string = 'StdOut.txt';
Mode         // Режим работы дисплея
             :  TModeVT;
TimerWork    // Признак работы таймера
             :  boolean;
//
// Параметры работы
// ================
NameServer   // Имя сервера по списку
             :  string;
TypeConnect  // Тип подключения
             // 0 - Telnet
             // 1 - SSH
             :  integer;
Address,     // Имя или адрес сервера
Port,        // Номер порта
SSHServerKey,// Ключ сервера
SSHLockPort  // Локальный порт сервера
             :  string;
Disconnect,  // Отключать от сервера при выходе
SetRaw       // Устанавливать RAW при подключении
             :  boolean;
//
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
LineSepIns    // Вставлять разделитель строк
              :  boolean= true;
LineSepSym    // Символ разделителя строк
              :  char;
LineSepNum    // Число символов для разделитель строк
              :  integer = 20;
TypeShowCtrl, // Отображение Ctrl-символов
              // 0 - Миганием
              // 1 - Прописными буквами
              // 3 - Пробелами
TimeCtrlBlink,// Интервал мигания Ctrl-символов
Keyboard      // Раскладка клавиатуры
              // 0 - WINDOWS
              // 1 - НВМЗ
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
Password      // Пароль для входа
              :  string;
StatusMPON,   // Сохраненное состояние MPON
StatusROLL,   // Сохраненное состояние ROLL
StatusBLINK   // Сохраненное состояние BLINK
              :  boolean;
EMailAdm      // Адрес администратора
              :  string = '';
EMailDev      // Адрес разработчика
              :  string = 'al-azizz@yandex.ru';
implementation
//
end.
