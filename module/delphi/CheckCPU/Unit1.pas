unit Unit1;
{$WARN SYMBOL_PLATFORM OFF}

interface

uses System.SysUtils, System.Variants, System.Classes, Winapi.ActiveX, System.Win.ComObj, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, RzRadChk, RzButton;

type
  TfrmCheckCPU = class(TForm)
    grp1: TGroupBox;
    chkMMX: TRzCheckBox;
    chkSSE1: TRzCheckBox;
    chkSSE2: TRzCheckBox;
    chkSSE3: TRzCheckBox;
    chkSSEE3: TRzCheckBox;
    chkSSE41: TRzCheckBox;
    chkSSE42: TRzCheckBox;
    chkAES: TRzCheckBox;
    chkAVX1: TRzCheckBox;
    chkFMA: TRzCheckBox;
    chkAVX2: TRzCheckBox;
    chkAVX512: TRzCheckBox;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

function GetCPUName: string;
var
  locator   : OLEVariant;
  services  : OLEVariant;
  processors: OLEVariant;
  processor : OLEVariant;
  enum      : IEnumVariant;
  fetched   : Cardinal;
begin
  Result := 'Unknown CPU';
  CoInitialize(nil);
  try
    locator    := CreateOleObject('WbemScripting.SWbemLocator');
    services   := locator.ConnectServer('.', 'root\cimv2');
    processors := services.ExecQuery('SELECT Name FROM Win32_Processor');
    enum       := IUnknown(processors._NewEnum) as IEnumVariant;

    if enum.Next(1, processor, fetched) = 0 then
      Result := processor.Name;
  except
    on E: Exception do
      Result := 'Error: ' + E.Message;
  end;
  CoUninitialize;
end;

{ 检测 CPU 支持的指令集 <Check CPU support instruction set> }
procedure CheckCPU(var bMMX, bSSE1, bSSE2, bSSE3, bSSEE3, bSSE41, bSSE42, bAES, bFMA, bAVX1, bAVX2, bAVX512: Boolean);
begin
  bMMX    := GetCPUID(1).EDX and (1 shl 23) = (1 shl 23);
  bSSE1   := GetCPUID(1).EDX and (1 shl 25) = (1 shl 25);
  bSSE2   := GetCPUID(1).EDX and (1 shl 26) = (1 shl 26);
  bSSE3   := GetCPUID(1).ECX and (1 shl 00) = (1 shl 00);
  bSSEE3  := GetCPUID(1).ECX and (1 shl 09) = (1 shl 09);
  bSSE41  := GetCPUID(1).ECX and (1 shl 19) = (1 shl 19);
  bSSE42  := GetCPUID(1).ECX and (1 shl 20) = (1 shl 20);
  bAES    := GetCPUID(1).ECX and (1 shl 25) = (1 shl 25);
  bAVX1   := GetCPUID(1).ECX and (1 shl 28) = (1 shl 28);
  bFMA    := GetCPUID(1).ECX and (1 shl 12) = (1 shl 12);
  bAVX2   := GetCPUID(7).EBX and (1 shl 05) = (1 shl 05);
  bAVX512 := GetCPUID(7).EBX and (1 shl 16) = (1 shl 16);
end;

procedure TfrmCheckCPU.FormCreate(Sender: TObject);
var
  bMMX, bSSE1, bSSE2, bSSE3, bSSEE3, bSSE41, bSSE42, bAES, bFMA, bAVX1, bAVX2, bAVX512: Boolean;
begin
  CheckCPU(bMMX, bSSE1, bSSE2, bSSE3, bSSEE3, bSSE41, bSSE42, bAES, bFMA, bAVX1, bAVX2, bAVX512);
  chkMMX.Checked    := bMMX;
  chkSSE1.Checked   := bSSE1;
  chkSSE2.Checked   := bSSE2;
  chkSSE3.Checked   := bSSE3;
  chkSSEE3.Checked  := bSSEE3;
  chkSSE41.Checked  := bSSE41;
  chkSSE42.Checked  := bSSE42;
  chkAES.Checked    := bAES;
  chkFMA.Checked    := bFMA;
  chkAVX1.Checked   := bAVX1;
  chkAVX2.Checked   := bAVX2;
  chkAVX512.Checked := bAVX512;

  lbl2.Caption := GetCPUName;
end;

end.
