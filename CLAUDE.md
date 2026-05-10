# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

VT-340 terminal emulator written in Object Pascal (Delphi/FreePascal), targeting Win32. Designed for connecting to the BESM-6 mainframe at `besm6.cs.msu.ru` via Telnet or SSH tunnel through `plink.exe`.

## Build Commands

```bash
# Standard build — on Linux, all paths are auto-detected
make

# Override LCL path (e.g. on macOS or non-standard install)
make LCLDIR=/path/to/lazarus/lcl/units/x86_64-linux

# Cross-compile to Win32 from Linux/macOS
make CROSS=1 FPC=/path/to/i386-win32-fpc LCLDIR=...

# Debug build (enables -g -gl -dDEBUG)
make DEBUG=1

make clean       # remove obj/ and bin/
make distclean   # same as clean
```

Output binary: `bin/vt340.exe` (Win32) or `bin/vt340` (native).

### Prerequisites

- `fpc` (FreePascal Compiler, Delphi compatibility mode `-Mdelphi`)
- Lazarus LCL units — on Ubuntu/Debian: `apt install lcl-units lcl-gtk2`
- Indy networking sources — checked out from Github as `Indy/` and compiled from source automatically
- `src/vt340.res` — must be built separately: `fpcres -o src/vt340.res src/vt340.rc`
- `src/*.dfm` — form layout files (present in repo for all forms)
- `plink.exe` — PuTTY's plink, bundled in repo, used for SSH tunneling

## Architecture

### Entry Point

`src/vt340.dpr` creates all forms and calls `Application.Run`. All forms are created at startup and reused throughout the session.

### Global State — `src/MainCV.pas`

All shared configuration lives here as global variables: connection parameters (`Address`, `Port`, `TypeConnect`, `SSHServerKey`), display settings (`Style`, `NumStrScreen`, `Keyboard`), runtime flags (`Mode`, `TimerWork`), and the INI filename (`Prm.ini`). Every other unit reads from and writes to these globals.

### Main Form — `src/UFormMain.pas`

The terminal display. Key components:
- `Memo: TMemo` — terminal screen buffer
- `IdTelnet: TIdTelnet` — Indy Telnet component; `IdTelnetDataAvailable` handles received bytes
- `Timer: TTimer` — drives periodic screen updates / blink effects
- Hardware-style VT-340 buttons: MPON, PERR, ROLL, BLINK, ERASE, SEND, DL, IL, DC, IC
- Keyboard handling split across `MemoKeyDown`, `MemoKeyPress`, `MemoKeyUp`

### SSH Transport

SSH is not implemented natively. Instead, `plink.exe` is launched as a subprocess to create a local TCP tunnel, then `IdTelnet` connects to `localhost:SSHLockPort`. The per-server SSH key fingerprint (`SSHServerKey`) and local tunnel port (`SSHLockPort`) are configured in `UFormSettingSSH`.

### Settings Persistence — `Prm.ini`

All settings are stored in INI format. Sections:
- `[Main]` — window geometry
- `[Server]` — active connection parameters
- `[List Servers]` — stored server list (name, type, address, port, SSH params)
- `[Screen]` — display, font, keyboard, password settings

### Platform Abstraction — `src/WinUnix.pas`

Wraps Win32 `EM_*` messages for `TMemo` scrolling (`EM_GETFIRSTVISIBLELINE`, `EM_LINESCROLL`, etc.). Linux stubs are no-ops. `src/UFormMain.pas` also guards Windows-only calls (`SendMessage`, `LockWindowUpdate`, `TPrintDialog`) with `{$IFDEF MSWINDOWS}`, using `Memo.CaretPos` as the Linux fallback for cursor-position queries. Printing is Windows-only.

### Form Units

| Unit | Purpose |
|------|---------|
| `UFormSettingsServer` | Server list management (add/delete/save servers to Prm.ini) |
| `UFormSettingSSH` | SSH tunnel parameters; reads `.ppk` private key file by server name |
| `UFormSettingsScreen` | Font, color, keyboard layout, Ctrl-char display mode |
| `UFormEntry` | Startup password check |
| `UFormSetPassword` | Password change dialog |
| `UFormSearch` | Text search in terminal Memo buffer |
| `UFormDebug` | Debug output window (shown via MMDebug menu) |
| `UFormHelp` | Help viewer |
| `UFormMessage` | Generic message dialog |
| `UFormLanguage` | Language/charset selection |

## Key Conventions

- Delphi compatibility mode (`-Mdelphi`) — use Delphi syntax, not pure FPC extensions.
- Russian comments throughout; variable names follow the pattern `Name // Comment` on a dedicated line.
- No unit tests; the build produces the single GUI executable.
- `{$IFDEF MSWINDOWS}` / `{$IFDEF LINUX}` used for platform branching in `WinUnix.pas` and `UFormMain.pas`.
- Cyrillic character literals in code (set ranges, array initialisers) must use CP1251 hex codes (`#$C0`–`#$DF` for А–Я, `#$E0`–`#$FF` for а–я) because the source files are UTF-8 and FPC rejects multi-byte chars where `Char` (AnsiChar) is expected.
