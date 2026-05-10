# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

VT-340 terminal emulator written in Object Pascal (Delphi/FreePascal), targeting Win32. Designed for connecting to the BESM-6 mainframe at `besm6.cs.msu.ru` via Telnet or SSH tunnel through `plink.exe`.

## Build Commands

```bash
# Standard build (must supply LCL path)
make LCLDIR=/path/to/lazarus/lcl/units/x86_64-linux/lcl

# With explicit Indy path
make LCLDIR=... INDYDIR=/path/to/indy/lib

# Cross-compile to Win32 from Linux/macOS
make CROSS=1 FPC=/path/to/i386-win32-fpc LCLDIR=... INDYDIR=...

# Debug build (enables -g -gl -dDEBUG)
make DEBUG=1 LCLDIR=...

make clean       # remove .ppu/.o/.a from obj/
make distclean   # remove bin/ and obj/ entirely
```

Output binary: `bin/VT340.exe` (Win32) or `bin/VT340` (native).

### Prerequisites

- `fpc` (FreePascal Compiler, Delphi compatibility mode `-Mdelphi`)
- Lazarus LCL units (Forms, Controls, StdCtrls, etc.)
- Indy networking units (IdTelnet, IdSMTP, etc.)
- `VT340.res` — must be built separately: `fpcres -o VT340.res VT340.rc`
- `*.dfm` — form layout files (present in repo)
- `plink.exe` — PuTTY's plink, bundled in repo, used for SSH tunneling

## Architecture

### Entry Point

`VT340.dpr` creates all forms and calls `Application.Run`. All forms are created at startup and reused throughout the session.

### Global State — `MainCV.pas`

All shared configuration lives here as global variables: connection parameters (`Address`, `Port`, `TypeConnect`, `SSHServerKey`), display settings (`Style`, `NumStrScreen`, `Keyboard`), runtime flags (`Mode`, `TimerWork`), and the INI filename (`Prm.ini`). Every other unit reads from and writes to these globals.

### Main Form — `UFormMain.pas`

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

### Platform Abstraction — `WinUnix.pas`

Wraps Win32 `EM_*` messages for `TMemo` scrolling. Linux stubs currently return `1` (non-functional). The codebase otherwise uses the `Windows` unit directly in several forms, so Linux builds are partially functional at best.

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
- `{$IFDEF MSWINDOWS}` / `{$IFDEF LINUX}` used for platform branching, primarily in `WinUnix.pas`.
