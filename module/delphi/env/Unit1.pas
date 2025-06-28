unit Unit1;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmEnv = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  end;

var
  frmEnv: TfrmEnv;

implementation

{$R *.dfm}

procedure TfrmEnv.FormCreate(Sender: TObject);
var
  EnvStrings: PChar;
  EnvVar    : string;
  P         : PChar;
begin
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
