{ Stub for LazarusPackageIntf — provides RegisterPackage/RegisterUnit so that
  Lazarus package-wrapper units (lazutils.pas, alllclunits.pp, registerlcl.pas,
  etc.) compile from a plain source checkout without the Lazarus IDE installed. }
unit LazarusPackageIntf;
{$mode objfpc}{$H+}
interface
type
  TRegisterProc = procedure;
procedure RegisterPackage(const Name: String; ARegProc: TRegisterProc);
procedure RegisterUnit(const UnitName: String; UnitRegProc: TRegisterProc);
implementation
procedure RegisterPackage(const Name: String; ARegProc: TRegisterProc);
begin
end;
procedure RegisterUnit(const UnitName: String; UnitRegProc: TRegisterProc);
begin
end;
end.
