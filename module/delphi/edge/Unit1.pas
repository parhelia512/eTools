unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ActiveX, System.IniFiles, System.SysUtils, System.Variants, System.Classes, System.Actions, WebView2,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ActnList, Vcl.StdCtrls, Vcl.Edge, Vcl.ComCtrls;

type
  TfrmEdge = class(TForm)
    EdgeBrowser: TEdgeBrowser;
    tmrStart: TTimer;
    procedure tmrStartTimer(Sender: TObject);
    procedure EdgeBrowserNavigationCompleted(Sender: TCustomEdgeBrowser; IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
    procedure EdgeBrowserCreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmEdge.EdgeBrowserCreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
var
  LSettings: ICoreWebView2Settings;
begin
  if Succeeded(AResult) then
  begin
    EdgeBrowser.DefaultInterface.Get_Settings(LSettings);
    if Assigned(LSettings) then
    begin
      LSettings.Set_AreDevToolsEnabled(0); // 禁用开发者工具
    end;
  end;
end;

procedure TfrmEdge.EdgeBrowserNavigationCompleted(Sender: TCustomEdgeBrowser; IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
begin
  { 在页面加载完成后注入 JavaScript 禁用右键 }
  EdgeBrowser.ExecuteScript('document.addEventListener("contextmenu", function(e){ e.preventDefault(); }, false);');
end;

procedure TfrmEdge.tmrStartTimer(Sender: TObject);
begin
  tmrStart.Enabled := False;
  EdgeBrowser.CreateWebView;
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini') do
  begin
    EdgeBrowser.Navigate(ReadString('WEB', 'URL', 'https://taobao.com'));
    Free;
  end;
end;

end.
