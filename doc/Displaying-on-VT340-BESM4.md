# Displaying Information on the VT-340 Terminal Connected to the BESM-4 Computer

**Author:** V.N. Kuznetsov  
**Source:** JINR preprint 10-8994, Joint Institute for Nuclear Research, Dubna, 1975  
**Original title (Russian):** Вывод информации на дисплей ВТ-340, подключённый к ЭВМ БЭСМ-4  
**Manuscript received:** 18 June 1975

*This document is an English translation of the original Russian preprint.*

---

## Introduction

The key characteristics of a modern experimental complex are:

- **Multi-component nature:** a computer or computer system operating in real time; communication equipment; registering and detecting apparatus; the primary source of information.
- **Significant spatial separation** of individual elements of the complex.
- **Direct participation** of a large team of workers of varying specialties and qualifications.

As methods for using computers on-line with experimental equipment develop, the problem of two-way operational dialog between the experimenter and the computer becomes increasingly important. Two main aspects of this problem can be identified:

1. Output of information about the course of the experiment and the results of processing to remote measurement centers.
2. Control of the computer and the complex as a whole by the experimenter.

The widespread adoption of the CAMAC standard throughout all links of an experimental complex partially addresses this problem through special modules such as indicators, constant-setting units, and computer-controlled modules — but their capabilities are limited.

Connecting a display with input/output functions can, in principle, solve the problems arising from the territorial remoteness of different links of the system and from organizing the experimenter–computer dialog.

The **VIDEOTON-340 alphanumeric video display (VT-340)** is connected to the BESM-4 computer via a CAMAC crate and an IDV interface (BESM-4 LBO), and is used as an input/output device in the measurement center. With this connection arrangement the display is regarded not as one of the computer's external devices but as part of the equipment of the physical installation.

This work addresses software for display output. The task of controlling the computer's operation via the display is solved individually for each experiment and is not discussed here. The following items are proposed:

- A method and program for creating a **library of constant image parts**
- A program for **outputting library images** to the display
- **Service programs** for working with the library
- Programs for **numeric and graphical output**
- Programs for **testing** the display and communication line

All programs are written in **ASSEMBLER**. The main programs are packaged as standard subroutines (SP) in the IS-2 system. They are introduced into the user's personal standard-program library (LIS) by the **PRELIS** program.

---

## §2. Technical Specifications of the Display and Interface

The VT-340 display is a universal medium-speed input/output device [1].

### Display Hardware

| Component | Description |
|-----------|-------------|
| 1 | Alphanumeric keyboard |
| 2 | Input/output matching unit |
| 3 | Buffer memory |
| 4 | Electronic circuits for executing control functions |
| 5 | Cathode ray tube (CRT) |
| 6 | Memory display unit on CRT |

### Technical Parameters

| Parameter | Value |
|-----------|-------|
| Screen diagonal | 280 mm |
| Useful area | 200 × 140 mm |
| Display capacity | 16 rows × 80 characters |
| Memory capacity | 16 × 80 = 1280 characters |
| Character format | 5 × 7 raster dots |
| Row width | 16 raster dots (7 + 4 underline dots + 5 spaces) |
| Position width | 7 raster dots (5 + 2 spaces) |
| Input/output speed | 110 to 1200 baud |
| Memory access time | 2 ms |
| Frame regeneration frequency | 50 Hz |

An alphanumeric printer (АЩПУ) can be connected directly to the display.

### Operating Modes

| # | Mode | Description |
|---|------|-------------|
| 1 | **OFF-LINE** | Autonomous mode. Keyboard connected to memory inputs. Input/output lines and printer output are inactive. |
| 2 | **ON-LINE** | Automatic operating mode with the computer. Input lines connected to memory inputs; keyboard connected to output lines. |
| 3 | **SEND** | Transmission mode. Characters read from memory are fed to the output line. |
| 4 | **PRINT** | Memory contents are output via dedicated lines to a printer connected directly to the display, allowing a screen copy to be obtained. |

### Character Set

The display supports **95 different characters** with **7-bit (semi-random) encoding**:

1. 10 digits
2. 28 special characters
3. 26 Latin letters
4. 31 Russian (Cyrillic) letters

Among the special characters, two functional groups can be identified: **control characters** and **text editing characters**.

### Control Characters

Characters marked with \* are **not stored** in display memory.

| # | Name | Code (octal) | Description |
|---|------|:------------:|-------------|
| 1\* | PRINT | 027 | Output screen contents to the autonomously connected printer. |
| 2 | ETX | 003 | End of text. In SEND mode, acts as end-of-transmission marker. When transmitted, the display automatically switches to ON-LINE mode. If ETX is absent, transition to ON-LINE occurs after the last character on screen is read. |
| 3\* | ERASE | 037 | Clear memory and move cursor to the home (initial) position. |
| 4 | HOME | 014 | Move cursor to the home position. Not executed during a read operation. |
| 5 | LINE FEED | 012 | Move cursor to the beginning of the next row. |
| 6 | TAB | 011 | Move cursor to the first character "J" found in the current row. If no "J" is present, acts as LINE FEED. |
| 7\* | CURSOR UP | 031 | Move cursor one row up. |
| 8\* | CURSOR DOWN | 032 | Move cursor one row down. |
| 9\* | CURSOR RIGHT | 030 | Move cursor one position to the right. |
| 10\* | CURSOR LEFT | 010 | Move cursor one position to the left. |

### Text Editing Operations

All text editing operations are marked \* (not stored in memory).

| # | Name | Code (octal) | Description |
|---|------|:------------:|-------------|
| 1\* | IC | 034 | **Insert Character.** Starting at the cursor position, all characters in the row shift one position to the right; the last character is lost. |
| 2\* | DC | 035 | **Delete Character.** The character at the cursor is erased; all characters to the right shift one position left; the last position becomes a space. |
| 3\* | IL | 013 | **Insert Line.** Starting at the cursor row, all rows shift down by one; the last row is lost; a blank row is created at the cursor position. |
| 4\* | DL | 036 | **Delete Line.** The cursor row is removed; all rows below it rise by one; the last row becomes blank. |

### Sequential Cursor Movement

When writing ordinary characters (not belonging to the control or editing groups), the cursor advances **one position to the right**. From the last position of a row it moves to the **beginning of the next row**. From the last position of the screen it wraps to the **beginning of the screen**.

---

## IDV Interface Characteristics

The IDV interface was developed and manufactured at the JINR Laboratory of Nuclear Problems [3]. It is implemented as a **CAMAC standard** module. The programmer has access to the following CAMAC functions:

| Function | Description |
|----------|-------------|
| `N, A(1), F(2)` | Query display status |
| `N, A(0), F(16)` | Write a character to the display |
| `N, A(0), F(25)` | Preparatory operation for reading |
| `N, A(0), F(2)` | Read a character from the display |

### Status Word Format

| Bit(s) | Meaning |
|:------:|---------|
| 1–8 | Not used |
| 9 | Ready to transmit |
| 10 | SEND mode active |
| 11 | Parity error |
| 12 | End of line |
| 13 | End of screen |
| 14 | Ready to receive |
| 15 | OFF-LINE mode |
| 16 | ON-LINE mode |

Due to the slow speed of internal display transformations, **group (burst) input/output cannot be organized.**

---

## §3. Method of Information Output

The presence of a buffer memory in the display, its software "addressability" via cursor movement instructions, and consequently the ability to write or read at any position on the screen, combined with the requirement to exchange **one character at a time**, determined the composition and structure of the service software library.

### Image Structure

An output image typically consists of two parts:

1. **Static objects** — the constant part: labels, supplementary inscriptions, coordinate axes, scale markings, etc.
2. **Dynamic objects** — the variable part: statistical characteristics of the experiment's progress, accumulated measurements, results of a processing stage.

Each part is prepared and output independently by separate programs that write image parts sequentially into display memory (**overlay**).

### Static Objects

Static objects can be hand-coded and stored in the user's program (output by SP MARS). The more practical approach is to **type the static image directly on the display keyboard in OFF-LINE mode** and then read it into the computer:

- The **LIBRARY** subroutine reads an image from the display, packs it, and enters it into the user's personal image library with an assigned number.
- The **MAP** subroutine outputs any library image to the display by number.

### Dynamic Objects

Dynamic objects are of two types:

- **Numeric arrays** — output by SP **NUMBER** (FORTRAN formats I, F, E, O).
- **Graphical information** — a function Y = F(X) specified as a table with constant step along X; output as a graph or histogram by SP **GRAF**.

### General Program Properties

- Output programs have **no internal stops** and cannot hang (e.g., if the display malfunctions or is not in ON-LINE mode).
- Each program exit corresponds to a **defined state of the test memory cell**.
- Programs can operate in **interrupt mode**, which is important when the computer is connected directly to the installation.

---

## Common Subroutine Parameters

Most subroutines share the following parameters:

| Parameter | Description |
|-----------|-------------|
| `Aet` | Cell address of the form `OJ, Nat, 0, 0`; `Nat` = octal IDV position number in the CAMAC crate |
| `K` (bit 44 of second call word) | `00` — reset screen before output, start from screen home position; `1` — no reset, start from current cursor position |
| `A` | Address of first cell containing the output data |
| `w` | Crate number where the data is located |
| `M` | Output type modification |

Working cells used internally: **1–10**. Flags **П1, П2, П3** are used in the standard sense for address modification.

### Test Cell (0.001) Exit States

| State | Meaning |
|-------|---------|
| `0` | Normal exchange completion |
| `0, 0, 1` | Ten consecutive failed attempts to write a character to the display |
| `0, 0, 1, 0` | Display not ready to receive for approximately 3 ms |
| `0, 1, 0, 0` | Status could not be read |
| `???, ????, ????, ????` | Display is not in ON-LINE mode |

---

## Subroutine Descriptions

### SP MAP — Output Library Image to Display

Outputs a stored image to the display by its library number.

**Call sequence:**
```
&   :  16, &+1, 7501, 7610
&+1 :  OK/100, Aet, № SP, № Nimg
```

- `Nimg` — octal image number.
- If the image `Nimg` is not found in the library, the message `"Nimg — image absent"` is output to the display.

**Subroutine size:** 144₈ words. Does not call other subroutines.

---

### SP MARS — Output Encoded Information to Display

Outputs characters to the display using 7-bit encoding. Supports two modes:

**Mode M = 0:** Up to 4 character codes packed per memory cell (bits KOP, A1, A2, A3).
- Zero codes are ignored (even a single character per cell is valid; the remaining bits must be zero).
- End-of-data marker: **code 177₈**.

**Mode M = 1:** Outputs the single character whose code is in bits 1–7 of cell A.

**Call sequence:**
```
&   :  16, &+1, 7501, 7610
&+1 :  OK|Km, Aet, № SP, A
```

**Subroutine size:** 124₈ words. Does not call other subroutines.

---

### SP GRAF — Output Graph or Histogram

Outputs a function Y = F(X) as a graph or histogram.

**Assumptions:**
- The function is specified as a table with **constant step along X** in MT points.
- Y values are normalized floating-point numbers stored in array A(MT).
- Before output, array A is normalized so that the **maximum value falls in the top row** of the display.
- In overlay mode (K = 1), the cursor must already be positioned in the top row at the column of the first graph point.

**Call sequence:**
```
&   :  16, &+1, 7501, 7610
&+1 :  OK|Km|Mt, Aet, № SP, A
&+2 :  00, NX-1, NI-1, 0
```

| Parameter | Description |
|-----------|-------------|
| `M = 0` | Output as histogram |
| `M = 1` | Output as graph (connected points) |
| `NX` | Step along the X axis in display positions |
| `MT` | Length of array A — number of graph points |

**Subroutine size:** 174₈ words. Does not call other subroutines.

---

### SP NUMBER — Output Numeric Arrays

Outputs numeric arrays in **FORTRAN formats**: `Iw`, `Fw.d`, `Ew.d`, `Ow.d`.

**Call sequence:**
```
&   :  16, &+1, 7501, 7610
&+1 :  OKO MN, Aet, № SP, WG
&+2 :  П1/П2/2052, A, NI-1, P-1
```

| Parameter | Description |
|-----------|-------------|
| `M` | Format selector: `0` = I, `1` = F, `2` = E, `3` = O |
| `W`, `d` | Two-digit octal format parameters (same meaning as FORTRAN for I, F, E) |
| `MI` | Length of the output array |
| `P` | Distance between adjacent numbers in display positions |

**Format O:** W specifies the number of output octal digits, starting from bit 55₈ − d.

**Overflow (W asterisks output instead of number):**

| Format | Overflow condition |
|--------|--------------------|
| I | Order of number П > W − 1. (Zero or negative order outputs `0` or `-0` in last positions.) |
| F | W < d + 2, or П > W − (d + 2) |
| E | W < d + 5 |

**Subroutine size:** 357₈ words. Internally uses **SP-10** (binary-to-decimal conversion).  
*Note: When used in the IS-2 system, the working field must be expanded.*

---

### SP LABEL — Position Cursor

Sets the cursor to a specified row and position **without resetting the screen**.

**Call sequence:**
```
&   :  16, &+1, 7501, 7610
&+1 :  OK/Mo, Aet, № SP, Npos
```

| K value | Behavior |
|---------|----------|
| `0` | Set cursor to the absolute row and position specified |
| `1` | Shift cursor relative to its current position |

**Addressing:**
- Rows are numbered **0 to 17₈** (top to bottom).
- Positions are numbered **0 to 117₈** (left to right).
- `Nstr` is a two-digit octal row number.
- `Npos` is a three-digit octal position number within the row.

**Wrap rules:**
- If `Nstr > 20₈`, the cursor moves **up** by (Nstr − 20₈).
- If `Npos > 200₈`, the cursor moves **left** by (Npos − 200₈).

**Subroutine size:** 100₈ words.

---

## Image Library

### Library Structure

The library resides in **RAM-3**, cells **4000₈–7777₈**, and consists of two parts:

| Region | Cells | Contents |
|--------|-------|----------|
| Catalog | 4000₈–4077₈ | Image catalog (up to 77₈ = 63 images) |
| Image data | 4100₈–4777₈ | Encoded and packed image data |

**Catalog record format:**

| Cell | Contents | Meaning |
|------|----------|---------|
| 4000₈ | `00, 0, A, K` | A = start of free field; K = count of existing images |
| 4000₈ + l | `00, 0, Al, Bl` | Start (Al) and end (Bl) of image l's storage field |
| 4000₈ + K | `777, 7777, 7777, 7777` | Marker indicating image K is absent |

**Packing:** 6 characters per cell (bits 42+1). A full-screen image (1280 characters) occupies 214₁₀ = **326₈ cells**.

The library with its catalog is normally stored on **magnetic tape** and loaded into RAM-3 before use.

---

### SP LIBRARY — Read Image from Display into Library

Reads an image typed on the display, packs it, enters it into the personal image library under a specified number, updates the catalog, and writes the library to magnetic tape.

**Preconditions before calling:**
- The required image must be typed on the display in **OFF-LINE mode**.
- Typing must begin from the **home (initial) position** of the screen.
- Any partially filled row must be terminated with **LINE FEED**.
- The **ETX** end-of-image marker is mandatory.
- Before calling, move the cursor to the home position using **HOME** and switch the display to **SEND mode**.

**Call sequence:**
```
&   :  16, &+1, 7501, 7610
&+1 :  00, 0, № SP, 0
```

**KZU-4 parameters:**

| Bit(s) | Meaning |
|:------:|---------|
| 45 | After reading and entering the image, write the library to magnetic tape (MT) with zone number "0" |
| 35+25 | Zone number of MT where the library will be written |
| 44 | If an image with the specified number already exists, overwrite it |
| 18+13 | Image number (octal) |
| 5+1 | IDV position number in the crate |

**Subroutine size:** 155₈ words.

**Internal stops:**

| Stop condition | Resolution |
|----------------|------------|
| `77, 7777` — image with this number already exists | Enable bit 44 of KZU-4 and press **Start** to overwrite |
| Program freezes at commands `50`, `70` | Display is not in SEND mode or is not operating |
| Machine halt at `50, 24, ...` | MT write required but MT is in wrong mode; press **Start** for a new write attempt |

---

## Standalone Programs

### Program OUT CAT — Output Library Catalog to Display

Outputs the library catalog to the display.

**Prerequisites:**
- Library loaded into RAM-3.
- SP MARS and SP NUMBER installed in LIS under numbers 234 and 235.
- LIS loaded via KZU-4 A1.

**Output format per catalog entry:**
```
NIN2  A1A2A3A4  B1B2B3B4
```

| Field | Description |
|-------|-------------|
| `NIN2` | Catalog row number (00–77₈) |
| `A1A2A3A4` | Second address of cell 4000₈ + NIN2 in RAM-3 |
| `B1B2B3B4` | Third address of same cell |

---

### Program OUT MAP — Output Images Sequentially to Display

Outputs a range of images from the library to the display in sequence.

**Prerequisites:**
- Library in RAM-3; LIS on MB-2; SP MAP installed in LIS under number 233.

**KZU-4 parameters:** `0, Nat, B, E`

| Parameter | Description |
|-----------|-------------|
| `Nat` | IDV position number in crate |
| `B` | Number of first image to output |
| `E` | Number of last image to output |

After each image is displayed, the program stops at `0037₈: 77₈`. Pressing **Start** outputs the next image.

---

### Program IN LIB — Load Library from Magnetic Tape

Reads the image library from magnetic tape (MT-0) into RAM-3.

- Set the zone number containing the library on KZU-4 A1.
- On successful read, the machine exits to input: **I0, I, I, 0**.

---

### Program TEST DISPLAY — Test Communication Line and Display

Tests the operation of the communication line and the display by reading an image typed on the display and writing it back one row lower.

**Test procedure:**

1. In **OFF-LINE mode**, type 2–3 rows of text. End with **ETX** and then **HOME**.
2. Switch the display to **SEND mode**.
3. On KZU-4: A1 = IDV position number in crate; bit 45 = flag to output diagnostic words to the narrow printer.
4. Start the program.

**Diagnostic output (when bit 45 is set and a fault is detected):**

Two words are printed:
1. The last word sent from the computer to the IDV.
2. An error code: `00, 0, 0, i`

**Error code values (i, octal):**

| Code (i) | Meaning |
|:--------:|---------|
| 1 | Function F(25) could not be written to IDV |
| 2 | Status could not be read |
| 4 | Display not in SEND mode (status bit 10 ≠ 1); first word contains the read status |
| 10 | No readiness to transmit (status bit 9 = 0); first word contains status |
| 20 | Function F(25) not written on second attempt; first word shows form: `3, 1000 + N, ...` |
| 40 | Next character could not be read; first word shows character-read function: `00, 2000 + N, ...` |
| 100 | Display not in ON-LINE mode (status bit 16 ≠ 1); first word contains status |
| 200 | Not ready to receive (status bit 14 ≠ 1); first word contains status |
| 400 | Character could not be written; first word shows write function: `2, N, 0, character code` |

---

## References

1. *Alphanumeric display type VT-340.* Manufacturer's instructions. Models ZID-47302-02-0A, ZID-47307-02-0A, ZID-47308-02-0A. Videoton.
2. T. Koba et al. JINR, IU-8759, Dubna, 1975.
3. L.G. Efimov, V.A. Smirnov. JINR, IU-6831, Dubna, 1975.
4. V.A. Zagivaiko, N.N. Silin. JINR, BI-II-4514, Dubna, 1968.
5. Z.M. Kvanichenko. JINR, IU-6141, Dubna, 1971.

---

*The author expresses gratitude to I.I. Kvanichenko for problem formulation and support, and to T.F. Smolyakova for useful discussions.*

*Published by the Editorial Department of the Joint Institute for Nuclear Research, Dubna. Order 19876. Print run 360. 1.05 printer's sheets. Signed for printing 27.06.75. Editor N.N. Zroleva. Proofreader R.D. Fomina.*
