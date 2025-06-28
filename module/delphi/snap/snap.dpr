library snap;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  Vcl.Forms,
  System.SysUtils,
  System.Classes,
  uMain in 'uMain.pas' {frmSnapScreen} ,
  uFullScreen in 'uFullScreen.pas' {frmFullScreen} ,
  frmCaptureScreen in 'frmCaptureScreen.pas' {frmCS};

{$R *.res}

type
  TLangStyle = (lsDelphi, lsVCDLG, lsVCMFC, lsQT, lsEXE);

procedure db_ShowDllForm_Plugins(var ls: TLangStyle; var frm: TFormClass; var strModuleName: PAnsiChar); stdcall;
begin
  ls            := lsDelphi;
  frm           := TfrmSnapScreen;
  strModuleName := 'Í¼ÐÎÍ¼Ïñ/ÆÁÄ»½ØÍ¼';
end;

exports
  db_ShowDllForm_Plugins;

begin

end.
