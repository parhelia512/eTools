library sp;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  Vcl.Forms,
  System.SysUtils,
  System.Classes,
  untSysSearch in 'untSysSearch.pas' {frmSysSearch};

{$R *.res}

type
 TLangStyle = (lsDelphi, lsVCDLG, lsVCMFC, lsQT, lsEXE);

procedure db_ShowDllForm_Plugins(var ls: TLangStyle; var frm: TFormClass; var strModuleName: PAnsiChar); stdcall;
begin
	ls            := lsDelphi;
  frm           := TfrmSysSearch;
  strModuleName := '系统管理/系统搜索路径';
end;

exports
  db_ShowDllForm_Plugins;

begin

end.
