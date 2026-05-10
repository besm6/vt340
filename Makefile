# Makefile for VT340 — FreePascal build
#
# Prerequisites:
#   fpc      FreePascal Compiler (https://www.freepascal.org)
#   Lazarus  LCL units required for Forms, Controls, StdCtrls, etc.
#   Indy     Indy networking units (IdTelnet, IdSMTP, etc.)
#
# Required files not in the repository:
#   *.dfm    Form resource files for each form unit (from Delphi/Lazarus IDE)
#   VT340.res  Application resource (icon, version info); build with:
#              fpcres -o VT340.res VT340.rc
#
# Usage:
#   make LCLDIR=/path/to/lazarus/lcl/units/<cpu-os>/lcl
#   make LCLDIR=... INDYDIR=/path/to/indy/lib
#   make CROSS=1 FPC=/path/to/cross-fpc LCLDIR=... INDYDIR=...
#   make DEBUG=1
#   make clean / distclean

FPC     ?= fpc
BINDIR  := bin
OBJDIR  := obj
PROGRAM := VT340

# Lazarus LCL units directory (required — provides Forms, Controls, etc.)
# Example: /Applications/Lazarus/lcl/units/x86_64-darwin/lcl
LCLDIR  ?=

# Indy components directory (required — provides IdTelnet, IdSMTP, etc.)
# Empty = rely on fpc system search path if Indy is installed globally.
INDYDIR ?=

# ---------------------------------------------------------------------------
# Target platform
# ---------------------------------------------------------------------------
# On Windows (MSYS2/Git Bash/Cygwin) the target is Win32 automatically.
# On macOS/Linux set CROSS=1 and point FPC to a win32-targeted cross-compiler.

HOST_OS := $(shell uname -s 2>/dev/null || echo Windows_NT)

ifeq ($(CROSS),1)
  TARGET_FLAGS := -Twin32 -Pi386
else ifneq (,$(filter MINGW% CYGWIN% MSYS%,$(HOST_OS)))
  TARGET_FLAGS := -Twin32 -Pi386
else ifneq (,$(findstring Windows_NT,$(HOST_OS)))
  TARGET_FLAGS := -Twin32 -Pi386
else
  TARGET_FLAGS :=
endif

ifneq (,$(findstring win32,$(TARGET_FLAGS)))
  EXE := $(BINDIR)/$(PROGRAM).exe
else
  EXE := $(BINDIR)/$(PROGRAM)
endif

# ---------------------------------------------------------------------------
# Compiler flags
# ---------------------------------------------------------------------------

UNIT_PATHS := -Fu.
ifneq ($(LCLDIR),)
  UNIT_PATHS += -Fu$(LCLDIR)
endif
ifneq ($(INDYDIR),)
  UNIT_PATHS += -Fu$(INDYDIR)
endif

ifeq ($(DEBUG),1)
  OPT_FLAGS := -g -gl -dDEBUG
else
  OPT_FLAGS := -O2 -Xs
endif

FPCFLAGS := -Mdelphi $(TARGET_FLAGS) -FE$(BINDIR) -FU$(OBJDIR) \
            $(UNIT_PATHS) $(OPT_FLAGS) -WG

# ---------------------------------------------------------------------------
# Sources
# ---------------------------------------------------------------------------

DPR := VT340.dpr

SOURCES := \
    MainCV.pas \
    WinUnix.pas \
    UFormDebug.pas \
    UFormEntry.pas \
    UFormHelp.pas \
    UFormLanguage.pas \
    UFormMain.pas \
    UFormMessage.pas \
    UFormSearch.pas \
    UFormSetPassword.pas \
    UFormSettingSSH.pas \
    UFormSettingsScreen.pas \
    UFormSettingsServer.pas

# ---------------------------------------------------------------------------
# Targets
# ---------------------------------------------------------------------------

.PHONY: all clean distclean

all: $(BINDIR) $(OBJDIR) $(EXE)

$(EXE): $(DPR) $(SOURCES)
	$(FPC) $(FPCFLAGS) $(DPR)

$(BINDIR) $(OBJDIR):
	mkdir -p $@

clean:
	$(RM) $(OBJDIR)/*.ppu $(OBJDIR)/*.o $(OBJDIR)/*.a

distclean: clean
	$(RM) -r $(BINDIR) $(OBJDIR)
