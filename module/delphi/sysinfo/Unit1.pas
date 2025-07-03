unit Unit1;

interface

uses Winapi.Windows, Winapi.Messages, Winapi.WinSock, System.SysUtils, System.Variants, System.Classes, Winapi.ActiveX, System.Win.ComObj, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdHTTP;

type
  TfrmSysInfo = class(TForm)
    lblOS: TLabel;
    lblOSValue: TLabel;
    lblCPU: TLabel;
    lblCPUValue: TLabel;
    lblMemory: TLabel;
    lblMemoryValue: TLabel;
    lblPCName: TLabel;
    lblPCNameValue: TLabel;
    lblIP: TLabel;
    lblIPValue: TLabel;
    procedure FormCreate(Sender: TObject);
  end;

var
  frmSysInfo: TfrmSysInfo;

implementation

{$R *.dfm}

procedure GetMemoryInfo(var TotalMemory, FreeMemory: UInt64);
var
  MemoryStatus: TMemoryStatusEx;
begin
  MemoryStatus.dwLength := SizeOf(MemoryStatus);
  if GlobalMemoryStatusEx(MemoryStatus) then
  begin
    TotalMemory := MemoryStatus.ullTotalPhys;
    FreeMemory  := MemoryStatus.ullAvailPhys;
  end
  else
  begin
    TotalMemory := 0;
    FreeMemory  := 0;
  end;
end;

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

function GetComputerName: string;
var
  Buffer: array [0 .. MAX_COMPUTERNAME_LENGTH] of Char;
  Size  : DWORD;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  if Winapi.Windows.GetComputerName(Buffer, Size) then
    Result := Buffer
  else
    Result := '';
end;

function GetLocalIPs: TArray<string>;
var
  WSAData : TWSAData;
  HostEnt : PHostEnt;
  Addr    : PAnsiChar;
  HostName: array [0 .. 255] of AnsiChar;
begin
  Result := nil;

  // 初始化Winsock
  if WSAStartup($0202, WSAData) <> 0 then
    Exit;

  try
    // 获取主机名
    if gethostname(HostName, SizeOf(HostName)) <> 0 then
      Exit;

    // 获取主机信息
    HostEnt := gethostbyname(HostName);
    if HostEnt = nil then
      Exit;

    // 遍历IP地址列表
    Addr := HostEnt^.h_addr_list^;
    while Addr <> nil do
    begin
      // 将IP地址转换为字符串格式
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := Format('%d.%d.%d.%d', [Byte(Addr[0]), Byte(Addr[1]), Byte(Addr[2]), Byte(Addr[3])]);

      // 移动到下一个IP地址
      Inc(HostEnt^.h_addr_list);
      Addr := HostEnt^.h_addr_list^;
    end;
  finally
    WSACleanup;
  end;
end;

function SyncUI(lblIPValue: TLabel; const strIP, strError: string): TThreadProcedure;
begin
  lblIPValue.Caption := lblIPValue.Caption + '(公网IP：' + strIP + ')';
end;

procedure GetNativePublicIP(lblIPValue: TLabel);
var
  Thread: TThread;
  tmd   : TThreadProcedure;
begin
  Thread := TThread.CreateAnonymousThread(
    procedure
    var
      IdHTTP: TIdHTTP;
      services: array of string;
      I: Integer;
      strIP, strError: string;
    begin
      strIP := '';
      strError := '';

      try
        IdHTTP := TIdHTTP.Create(nil);
        try
          IdHTTP.ConnectTimeout := 5000;
          IdHTTP.ReadTimeout := 5000;
          services := ['http://ipinfo.io/ip', 'http://icanhazip.com', 'http://checkip.amazonaws.com'];
          for I := 0 to High(services) do
          begin
            try
              strIP := Trim(IdHTTP.Get(services[I]));
              if (Pos('.', strIP) > 0) and (Length(strIP) >= 7) then
                Break;
            except
              on E: Exception do
              begin
                strError := E.Message;
                strIP := '';
              end;
            end;
          end;
        finally
          IdHTTP.Free;
        end;
      except
        on E: Exception do
          strError := E.Message;
      end;

      if strIP <> '' then
      begin
        tmd := SyncUI(lblIPValue, strIP, strError);
        TThread.Queue(nil, tmd);
      end;
    end);
  Thread.FreeOnTerminate := True;
  Thread.Start;
end;

procedure TfrmSysInfo.FormCreate(Sender: TObject);
var
  TotalMem, FreeMem: UInt64;
begin
  GetMemoryInfo(TotalMem, FreeMem);

  lblOSValue.Caption     := TOSVersion.ToString;
  lblCPUValue.Caption    := GetCPUName;
  lblMemoryValue.Caption := Format('总大小：%.2fG；可用内存：%.2fG', [TotalMem / (1024 * 1024 * 1024), FreeMem / (1024 * 1024 * 1024)]);
  lblPCNameValue.Caption := GetComputerName;
  lblIPValue.Caption     := GetLocalIPs[0];
  GetNativePublicIP(lblIPValue);
end;

end.
