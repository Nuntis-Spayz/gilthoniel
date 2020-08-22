unit frmHelp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, IpHtml, Ipfilebroker,
  fileinfo, LCLIntf, IpMsg;

type

  { TFormHelp }

  TFormHelp = class(TForm)
    IpFileDP: TIpFileDataProvider;
    IpHtmlPanel1: TIpHtmlPanel;
    procedure FormCreate(Sender: TObject);
    procedure IpHtmlPanel1HotClick(Sender: TObject);
  private

  public
    procedure OpenShow(title, url : String);

  end;

var
  FormHelp: TFormHelp;

implementation

{$R *.lfm}

{ TFormHelp }

procedure TFormHelp.OpenShow(title, url : String);
var
  ds : String;
  tss : TStringStream;
  Info : TVersionInfo;
  appVersion : String;
begin
  if title.IsEmpty then
    Caption:='Gilthoniel Help'
  else
    Caption:=title;

  tss := TStringStream.Create;
  tss.LoadFromStream(IpFileDP.GetHtmlStream(url, nil));
  ds:=tss.UnicodeDataString;

  if ds.Contains('{ver}') then
  begin
    Info := TVersionInfo.Create;
    Info.Load(HINSTANCE);
    //[0] = Major version, [1] = Minor ver, [2] = Revision, [3] = Build Number
    appVersion:= IntToStr(Info.FixedInfo.FileVersion[0])
            +'.'+IntToStr(Info.FixedInfo.FileVersion[1])
            +'.'+IntToStr(Info.FixedInfo.FileVersion[2])
            +'.'+IntToStr(Info.FixedInfo.FileVersion[3]);
    ds := ds.Replace('{ver}',appVersion);

    Info.Free;
  end;

  IpHtmlPanel1.SetHtmlFromStr(ds);

  if IpHtmlPanel1.Caption<>'' then
     Caption:=IpHtmlPanel1.Caption;

  Show;
end;

procedure TFormHelp.FormCreate(Sender: TObject);
begin
  //-- --
end;

procedure TFormHelp.IpHtmlPanel1HotClick(Sender: TObject);
var
 s : String;
begin
  s := IpHtmlPanel1.HotURL;
  if s.StartsWith('http') then
    OpenURL(s)
  else
  begin
    if Not s.StartsWith('help/') then
       s := 'help/'+s;

    OpenShow('', s);
  end;

end;

end.

