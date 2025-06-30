unit Unit1;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uScrollBar, Vcl.ExtCtrls;

type
  TfrmEnv = class(TForm)
    Memo1: TMemo;
    tmrStart: TTimer;
    procedure tmrStartTimer(Sender: TObject);
  private
    FSBLV: TFMScrollBar;
  end;

var
  frmEnv: TfrmEnv;

implementation

{$R *.dfm}

procedure TfrmEnv.tmrStartTimer(Sender: TObject);
var
  EnvStrings: PChar;
  EnvVar    : string;
  P         : PChar;
begin
  tmrStart.Enabled := False;
  FSBLV            := TFMScrollBar.Create(nil);
  FSBLV.InitScrollbar(Memo1);

  EnvStrings := GetEnvironmentStrings;
  try
    P := EnvStrings;
    while P^ <> #0 do
    begin
      EnvVar := P;
      Memo1.Lines.Add(EnvVar);
      Inc(P, Length(EnvVar) + 1);
    end;
  finally
    FreeEnvironmentStrings(EnvStrings);
  end;
end;

end.
