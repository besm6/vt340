# Makefile for VT340 — FreePascal build
#
# Prerequisites:
#   fpc      FreePascal Compiler (https://www.freepascal.org)
#   Lazarus  LCL units required for Forms, Controls, StdCtrls, etc.
#
# Usage:
#   make                                    (Linux/macOS — LCL built from Lazarus/)
#   make LCLDIR=...                         (override LCL path)
#   make CROSS=1 FPC=/path/to/cross-fpc LCLDIR=...
#   make DEBUG=1
#   make clean / distclean

FPC     ?= fpc
BINDIR  := bin
OBJDIR  := obj
PROGRAM := vt340

# Lazarus LCL units directory (required — provides Forms, Controls, etc.)
# Built from the Lazarus/ source checkout on Linux and macOS.
# Override: make LCLDIR=/path/to/lcl/units/...

# ---------------------------------------------------------------------------
# Linux/macOS: build LCL from the Lazarus/ source checkout
# ---------------------------------------------------------------------------

HOST_OS := $(shell uname -s 2>/dev/null || echo Windows_NT)

# Detect FPC target CPU and OS for path construction (e.g. x86_64, linux)
FPC_CPU  := $(shell $(FPC) -iTP 2>/dev/null)
FPC_OS   := $(shell $(FPC) -iTO 2>/dev/null)
LCL_ARCH := $(FPC_CPU)-$(FPC_OS)

ifeq ($(HOST_OS),Linux)
  LAZARUSDIR   := Lazarus
  LCLDIR       ?= $(LAZARUSDIR)/lcl/units/$(LCL_ARCH)
  LCLGTK2DIR   ?= $(LAZARUSDIR)/lcl/units/$(LCL_ARCH)/gtk2
  LAZUTILSDIR  ?= $(LAZARUSDIR)/components/lazutils/lib/$(LCL_ARCH)
  FCLPROCDIR   ?= /usr/lib/$(FPC_CPU)-linux-gnu/fpc/3.2.2/units/$(LCL_ARCH)/fcl-process
  LCL_PLATFORM := gtk2
  LCL_STAMP    := $(LAZARUSDIR)/lcl/units/$(LCL_ARCH)/.built
endif

ifeq ($(HOST_OS),Darwin)
  LAZARUSDIR   := Lazarus
  LCLDIR       ?= $(LAZARUSDIR)/lcl/units/$(LCL_ARCH)
  LCLCOCOADIR  ?= $(LAZARUSDIR)/lcl/units/$(LCL_ARCH)/cocoa
  LAZUTILSDIR  ?= $(LAZARUSDIR)/components/lazutils/lib/$(LCL_ARCH)
  FCLPROCDIR   ?= /usr/local/lib/fpc/3.2.2/units/$(LCL_ARCH)/fcl-process
  LCL_PLATFORM := cocoa
  LCL_STAMP    := $(LAZARUSDIR)/lcl/units/$(LCL_ARCH)/.built
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

UNIT_PATHS := -Fusrc
ifneq ($(LCLDIR),)
  UNIT_PATHS += -Fu$(LCLDIR)
endif
ifneq ($(LCLGTK2DIR),)
  UNIT_PATHS += -Fu$(LCLGTK2DIR)
endif
ifneq ($(LCLCOCOADIR),)
  UNIT_PATHS += -Fu$(LCLCOCOADIR)
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
else ifeq ($(HOST_OS),Darwin)
  LCL_FLAGS   := -dLCL -dLCLcocoa
  SUBSYS_FLAG := -k-framework -kUserNotifications
else
  LCL_FLAGS   :=
  SUBSYS_FLAG := -WG
endif

FPCFLAGS := -Mdelphi $(TARGET_FLAGS) -FE$(BINDIR) -FU$(OBJDIR) \
            $(UNIT_PATHS) $(OPT_FLAGS) $(LCL_FLAGS) $(SUBSYS_FLAG)

# ---------------------------------------------------------------------------
# Sources
# ---------------------------------------------------------------------------

DPR := src/vt340.dpr

SOURCES := \
    src/MainCV.pas \
    src/WinUnix.pas \
    src/UFormDebug.pas \
    src/UFormEntry.pas \
    src/UFormHelp.pas \
    src/UFormLanguage.pas \
    src/UFormMain.pas \
    src/UFormMessage.pas \
    src/UFormSearch.pas \
    src/UFormSetPassword.pas \
    src/UFormSettingSSH.pas \
    src/UFormSettingsScreen.pas \
    src/UFormSettingsServer.pas

# ---------------------------------------------------------------------------
# Targets
# ---------------------------------------------------------------------------

.PHONY: all clean distclean

all: $(BINDIR) $(OBJDIR) $(EXE)

$(EXE): $(DPR) $(SOURCES) Indy Lazarus $(LCL_STAMP)
	$(FPC) $(FPCFLAGS) $(DPR)

$(BINDIR) $(OBJDIR):
	mkdir -p $@

Indy:
	git clone https://github.com/IndySockets/Indy.git

Lazarus:
	git clone --branch fixes_3_0 https://github.com/fpc/Lazarus.git

ifneq ($(LCL_STAMP),)
# Compile LCL from the Lazarus/ source checkout (Linux/macOS).
$(LCL_STAMP): Lazarus
	cp stubs/LazarusPackageIntf.pas $(LAZARUSDIR)/components/lazutils/
	cd $(LAZARUSDIR)/components/lazutils && $(MAKE) -j1 FPC=$(FPC)
	cd $(LAZARUSDIR)/components/freetype && $(MAKE) -j1 FPC=$(FPC)
	cd $(LAZARUSDIR)/lcl && $(MAKE) -j1 FPC=$(FPC) LCL_PLATFORM=$(LCL_PLATFORM)
	touch $@
endif

clean:
	$(RM) -rf $(OBJDIR) $(BINDIR)

distclean: clean
	$(RM) -r $(BINDIR) $(OBJDIR)
