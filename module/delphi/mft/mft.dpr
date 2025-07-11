library mft;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {frmNTFSScan};

{$R *.res}

type
  TLangStyle = (lsDelphi, lsVCDLG, lsVCMFC, lsQT, lsEXE);

procedure db_ShowDllForm_Plugins(var ls: TLangStyle; var frm: TFormClass; var strModuleName: PAnsiChar); stdcall;
begin
  ls            := lsDelphi;
  frm           := TfrmNTFSScan;
  strModuleName := '系统管理/NTFS文件扫描';
end;

exports
  db_ShowDllForm_Plugins;

begin

end.
