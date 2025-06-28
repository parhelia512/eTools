unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ActiveX, System.SysUtils, System.Variants, System.Classes, System.Win.ComObj, System.IOUtils, System.Contnrs, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  mormot.core.base, mormot.orm.core, mormot.core.json, mormot.rest.sqlite3, mormot.DB.raw.sqlite3, mormot.DB.raw.sqlite3.static, sevenzip;

type
  TfrmChina = class(TForm)
    grpProvince: TGroupBox;
    cbbProvince: TListBox;
    grpCity: TGroupBox;
    cbbCity: TListBox;
    grpCity1: TGroupBox;
    cbbArea: TListBox;
    grpCity2: TGroupBox;
    cbbStreet: TListBox;
    grpCity11: TGroupBox;
    cbbVillage: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbbProvinceChange(Sender: TObject);
    procedure cbbCityChange(Sender: TObject);
    procedure cbbAreaChange(Sender: TObject);
    procedure cbbStreetChange(Sender: TObject);
  private
    FsqliteDB: TMemoryStream;
    FDB      : TSqlDatabase;
    procedure ConnectedDataBase(const str7zDllFile: string);
    procedure AddItemData(Records: TObjectList; cbb: TListBox; const iItemIndex: Integer = 0);
  end;

implementation

{$R *.dfm}

type
  TProvince = class(TSQLRecord)
  private
    FCode: Integer;
    FName: RawUTF8;
  published
    property Code: Integer read FCode write FCode;
    property Name: RawUTF8 read FName write FName;
  end;

  TCity = class(TSQLRecord)
  private
    FCode: Integer;
    FName: RawUTF8;
  published
    property Code: Integer read FCode write FCode;
    property Name: RawUTF8 read FName write FName;
  end;

  TArea = class(TSQLRecord)
  private
    FCode: Integer;
    FName: RawUTF8;
  published
    property Code: Integer read FCode write FCode;
    property Name: RawUTF8 read FName write FName;
  end;

  TStreet = class(TSQLRecord)
  private
    FCode: Integer;
    FName: RawUTF8;
  published
    property Code: Integer read FCode write FCode;
    property Name: RawUTF8 read FName write FName;
  end;

  TVillage = class(TSQLRecord)
  private
    FCode: Integer;
    FName: RawUTF8;
  published
    property Code: Integer read FCode write FCode;
    property Name: RawUTF8 read FName write FName;
  end;

function Get7zipPath: PChar; stdcall; external 'eTools.exe';

procedure TfrmChina.FormCreate(Sender: TObject);
var
  str7zDllFile: string;
begin
  str7zDllFile := string(Get7zipPath);
  ConnectedDataBase(str7zDllFile);
end;

procedure TfrmChina.FormDestroy(Sender: TObject);
begin
  FsqliteDB.free;
end;

procedure TfrmChina.AddItemData(Records: TObjectList; cbb: TListBox; const iItemIndex: Integer = 0);
var
  I: Integer;
begin
  for I := 0 to Records.Count - 1 do
  begin
    with TProvince(Records[I]) do
    begin
      cbb.Items.AddObject(string(Name), TObject(Records[I]));
    end;
  end;
  cbb.ItemIndex := iItemIndex;
end;

procedure TfrmChina.ConnectedDataBase(const str7zDllFile: string);
const
  SQLITE_DESERIALIZE_FREEONCLOSE = 1;
  SQLITE_DESERIALIZE_READONLY    = 4;
var
  archive: I7zInArchive;
  Model  : TSQLModel;
  rsDB   : TRestServerDB;
  Records: TObjectList;
begin
  archive := CreateInArchive(CLSID_CFormat7z, str7zDllFile);
  archive.OpenStream(T7zStream.Create(TResourceStream.Create(HInstance, 'CHINA', RT_RCDATA), soOwned));
  FsqliteDB := TMemoryStream.Create;
  archive.ExtractItem(0, FsqliteDB, false);
  FsqliteDB.Position := 0;

  { 连接内存数据库 }
  FDB := TSqlDatabase.Create(SQLITE_MEMORY_DATABASE_NAME);
  sqlite3.deserialize(FDB.DB, 'main', FsqliteDB.Memory, FsqliteDB.Size, FsqliteDB.Size, SQLITE_DESERIALIZE_FREEONCLOSE);

  { 读取省列表 }
  cbbProvince.Clear;
  cbbCity.Clear;
  cbbArea.Clear;
  cbbStreet.Clear;
  cbbVillage.Clear;

  Model   := TSQLModel.Create([TProvince], 'province');
  rsDB    := TSQLRestServerDB.Create(Model, FDB);
  Records := rsDB.RetrieveList(TProvince, '', [], 'code,name');
  try
    AddItemData(Records, cbbProvince, 8);
    cbbProvinceChange(nil);
  finally
    rsDB.free;
  end;
end;

procedure TfrmChina.cbbProvinceChange(Sender: TObject);
var
  iCode  : Integer;
  Model  : TSQLModel;
  rsDB   : TRestServerDB;
  Records: TObjectList;
begin
  cbbCity.Clear;
  cbbArea.Clear;
  cbbStreet.Clear;
  cbbVillage.Clear;

  iCode   := TProvince(cbbProvince.Items.Objects[cbbProvince.ItemIndex]).Code;
  Model   := TSQLModel.Create([TCity], 'city');
  rsDB    := TSQLRestServerDB.Create(Model, FDB);
  Records := rsDB.RetrieveList(TCity, RawUTF8(Format('provinceCode=%d', [iCode])), [], 'code,name');
  try
    AddItemData(Records, cbbCity);
    cbbCityChange(nil);
  finally
    rsDB.free;
  end;
end;

procedure TfrmChina.cbbCityChange(Sender: TObject);
var
  iProvinceCode, iCityCode: Integer;
  Model                   : TSQLModel;
  rsDB                    : TRestServerDB;
  Records                 : TObjectList;
begin
  cbbArea.Clear;
  cbbStreet.Clear;
  cbbVillage.Clear;

  { 读取县或区列表 }
  iProvinceCode := TProvince(cbbProvince.Items.Objects[cbbProvince.ItemIndex]).Code;
  iCityCode     := TCity(cbbCity.Items.Objects[cbbCity.ItemIndex]).Code;
  Model         := TSQLModel.Create([TArea], 'area');
  rsDB          := TSQLRestServerDB.Create(Model, FDB);
  Records       := rsDB.RetrieveList(TArea, RawUTF8(Format('provinceCode=%d and cityCode=%d', [iProvinceCode, iCityCode])), [], 'code,name');
  try
    AddItemData(Records, cbbArea);
    cbbAreaChange(nil);
  finally
    rsDB.free;
  end;
end;

procedure TfrmChina.cbbAreaChange(Sender: TObject);
var
  iProvinceCode, iCityCode, iAreaCode: Integer;
  Model                              : TSQLModel;
  rsDB                               : TRestServerDB;
  Records                            : TObjectList;
begin
  cbbStreet.Clear;
  cbbVillage.Clear;

  { 读取街道列表 }
  iProvinceCode := TProvince(cbbProvince.Items.Objects[cbbProvince.ItemIndex]).Code;
  iCityCode     := TCity(cbbCity.Items.Objects[cbbCity.ItemIndex]).Code;
  iAreaCode     := TArea(cbbArea.Items.Objects[cbbArea.ItemIndex]).Code;
  Model         := TSQLModel.Create([TStreet], 'street');
  rsDB          := TSQLRestServerDB.Create(Model, FDB);
  Records       := rsDB.RetrieveList(TStreet, RawUTF8(Format('provinceCode=%d and cityCode=%d and areaCode=%d', [iProvinceCode, iCityCode, iAreaCode])), [], 'code,name');
  try
    AddItemData(Records, cbbStreet);
    cbbStreetChange(nil);
  finally
    rsDB.free;
  end;
end;

procedure TfrmChina.cbbStreetChange(Sender: TObject);
var
  iProvinceCode, iCityCode, iAreaCode, iStreetCode: Integer;
  Model                                           : TSQLModel;
  rsDB                                            : TRestServerDB;
  Records                                         : TObjectList;
begin
  cbbVillage.Clear;

  { 读取居委会列表 }
  iProvinceCode := TProvince(cbbProvince.Items.Objects[cbbProvince.ItemIndex]).Code;
  iCityCode     := TCity(cbbCity.Items.Objects[cbbCity.ItemIndex]).Code;
  iAreaCode     := TArea(cbbArea.Items.Objects[cbbArea.ItemIndex]).Code;
  iStreetCode   := TStreet(cbbStreet.Items.Objects[cbbStreet.ItemIndex]).Code;
  Model         := TSQLModel.Create([TVillage], 'village');
  rsDB          := TSQLRestServerDB.Create(Model, FDB);
  Records       := rsDB.RetrieveList(TVillage, RawUTF8(Format('provinceCode=%d and cityCode=%d and areaCode=%d and streetCode=%d', [iProvinceCode, iCityCode, iAreaCode, iStreetCode])), [], 'code,name');
  try
    AddItemData(Records, cbbVillage);
  finally
    rsDB.free;
  end;
end;

end.
