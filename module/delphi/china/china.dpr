library china;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  Vcl.Forms,
  System.SysUtils,
  System.Classes,
  Unit1 in 'Unit1.pas' {frmChina};

{$R *.res}
{$R data.res}

type
  TLangStyle = (lsDelphi, lsVCDLG, lsVCMFC, lsQT, lsEXE);

procedure db_ShowDllForm_Plugins(var ls: TLangStyle; var frm: TFormClass; var strModuleName: PAnsiChar); stdcall;
begin
  ls            := lsDelphi;
  frm           := TfrmChina;
  strModuleName := '系统管理/中国行政区划';
end;

exports
  db_ShowDllForm_Plugins;

begin

end.
