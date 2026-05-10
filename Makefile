# Makefile for VT340 — FreePascal build
#
# Prerequisites:
#   fpc      FreePascal Compiler (https://www.freepascal.org)
#   Lazarus  LCL units required for Forms, Controls, StdCtrls, etc.
#
# Usage:
#   make                                    (Linux — all paths auto-detected)
#   make LCLDIR=...                         (override LCL path)
#   make CROSS=1 FPC=/path/to/cross-fpc LCLDIR=...
#   make DEBUG=1
#   make clean / distclean

FPC     ?= fpc
BINDIR  := bin
OBJDIR  := obj
PROGRAM := VT340

# Lazarus LCL units directory (required — provides Forms, Controls, etc.)
# On Linux with lazarus 3.0 + lcl-units-3.0 this is set automatically below.
# Example override: /Applications/Lazarus/lcl/units/x86_64-darwin/lcl

# ---------------------------------------------------------------------------
# Linux: auto-detect installed Lazarus 3.0 paths
# (packages: lazarus, lcl-units-3.0, lcl-gtk2-3.0)
# ---------------------------------------------------------------------------

HOST_OS := $(shell uname -s 2>/dev/null || echo Windows_NT)

ifeq ($(HOST_OS),Linux)
  LCLDIR      ?= /usr/lib/lazarus/3.0/lcl/units/x86_64-linux
  LCLGTK2DIR  ?= /usr/lib/lazarus/3.0/lcl/units/x86_64-linux/gtk2
  LAZUTILSDIR ?= /usr/lib/lazarus/3.0/components/lazutils/lib/x86_64-linux
  FCLPROCDIR  ?= /usr/lib/x86_64-linux-gnu/fpc/3.2.2/units/x86_64-linux/fcl-process
endif

# ---------------------------------------------------------------------------
# Target platform
# ---------------------------------------------------------------------------
# On Windows (MSYS2/Git Bash/Cygwin) the target is Win32 automatically.
# On macOS/Linux set CROSS=1 and point FPC to a win32-targeted cross-compiler.

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
ifneq ($(LCLGTK2DIR),)
  UNIT_PATHS += -Fu$(LCLGTK2DIR)
endif
ifneq ($(LAZUTILSDIR),)
  UNIT_PATHS += -Fu$(LAZUTILSDIR)
endif
ifneq ($(FCLPROCDIR),)
  UNIT_PATHS += -Fu$(FCLPROCDIR)
endif
UNIT_PATHS += -FuIndy/Lib/System
UNIT_PATHS += -FuIndy/Lib/SuperCore
UNIT_PATHS += -FuIndy/Lib/Core
UNIT_PATHS += -FuIndy/Lib/Protocols
UNIT_PATHS += -FuIndy/Lib/Security

ifeq ($(DEBUG),1)
  OPT_FLAGS := -g -gl -dDEBUG
else
  OPT_FLAGS := -O2 -Xs
endif

# LCL widgetset and subsystem flags: GTK2 on Linux, Windows GUI on Win32
ifeq ($(HOST_OS),Linux)
  LCL_FLAGS   := -dLCL -dLCLgtk2
  SUBSYS_FLAG :=
else
  LCL_FLAGS   :=
  SUBSYS_FLAG := -WG
endif

FPCFLAGS := -Mdelphi $(TARGET_FLAGS) -FE$(BINDIR) -FU$(OBJDIR) \
            $(UNIT_PATHS) $(OPT_FLAGS) $(LCL_FLAGS) $(SUBSYS_FLAG)

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

$(EXE): $(DPR) $(SOURCES) Indy
	$(FPC) $(FPCFLAGS) $(DPR)

$(BINDIR) $(OBJDIR):
	mkdir -p $@

Indy:
	git clone https://github.com/IndySockets/Indy.git

clean:
	$(RM) -rf $(OBJDIR) $(BINDIR)

distclean: clean
	$(RM) -r $(BINDIR) $(OBJDIR)
