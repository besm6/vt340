# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **VT-340 terminal emulator** written in Delphi/Object Pascal. VT-340 was a DEC video terminal; this application emulates it with support for Telnet/SSH connections to Soviet-era BESM-6 systems, Cyrillic character encoding, and multiple keyboard layouts.

The entire codebase lives in a single file: [UFormMain_utf8.pas](UFormMain_utf8.pas) (3,209 lines).

## Build

No build scripts are present in the repository. This is a Delphi project — build via the Delphi IDE (Borland/Embarcadero) or FreePascal/Lazarus. The `.dpr`/`.dpk` project files are not tracked here.

External dependencies: Indy networking components (IdTelnet, IdSMTP, IdIMAP4), plink.exe (for SSH tunneling via PuTTY).

Configuration is stored in `Prm.ini` at runtime.

## Architecture

The file contains six Delphi units in sequence:

| Unit | Purpose |
|------|---------|
| `MainCV` | Global constants and variables shared by all forms (connection params, display mode, keyboard layout) |
| `UFormDebug` | Debug/diagnostic log window; can dump to file |
| `UFormEntry` | Password dialog with attempt counter and lockout timeout |
| `UFormHelp` | Help window: displays `Instr.txt`, email support buttons (SMTP/IMAP config) |
| `UFormLanguage` | Language/localization stub (minimal implementation) |
| `UFormMain` | Main window (~2,850 lines) — terminal screen, menus, keyboard handling, connection management |

### Key subsystems in `UFormMain`

- **Screen rendering**: `StrScreenToMemo` — renders the terminal screen buffer into a TMemo with scroll support (configurable 16-row, custom, or window-height modes)
- **Keyboard input**: `KeyToSym` / `KeyToSymNVMZ` — maps physical keys to terminal symbols for Latin/Russian QWERTY and НВМЗ layouts; `MemoKeyDown`/`MemoKeyUp`/`MemoKeyPress` handle WM_KEY* messages
- **Encoding**: `StrToLat`, `StrToRus`, `CharToBESM6`, `StrToBESM6`, `ByteArrayToHexString` — bidirectional Cyrillic ↔ BESM-6 encoding conversions
- **Connection**: Telnet via Indy `IdTelnet`; SSH via spawning `plink.exe` as a subprocess with stdin/stdout pipes
- **Terminal commands**: MPON, ROLL, BLINK, ERASE, DL, IL, DC, IC — sent as escape sequences to the remote host
- **Settings persistence**: `ReadPrmServer`/`WritePrmServer`, `ReadPrmScreen`/`WritePrmScreen` — read/write `Prm.ini`

### Notable design details

- Online/Offline mode toggle controls whether keystrokes are sent to the remote host or edited locally
- Insert/Overwrite mode affects how characters are placed in the screen buffer
- The screen buffer is a string array indexed by row; `StrScreenToMemo` rebuilds the TMemo content on each update
- Cyrillic support requires explicit conversion at input and output boundaries because the target system (BESM-6) uses its own encoding
